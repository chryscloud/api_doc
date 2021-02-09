# Displaying live video stream with OpenCV

Example demonstrated displaying a live video stream and probing in memory buffer if it exists.

`opencv_display.py:`
```python
import grpc
import video_streaming_pb2_grpc, video_streaming_pb2
import argparse
import cv2
import numpy as np
import time
import os

def gen_buffer_probe_request(device_name):
    """ Create GRPC request to get in memory probe info """

    req = video_streaming_pb2.VideoProbeRequest()
    req.device_id = device_name

    return req

def gen_image_request(device_name, keyframe_only):
    """ Create an object to request a video frame """


    req = video_streaming_pb2.VideoFrameRequest()
    req.device_id = device_name
    req.key_frame_only = keyframe_only
    return req

if __name__ == "__main__":
    
    parser = argparse.ArgumentParser(description='Chrysalis Edge Proxy Basic Example')
    parser.add_argument("--device", type=str, default=None, required=True)
    parser.add_argument("--keyframe", action='store_true')
    args = parser.parse_args()

    # grpc connection to video-edge-ai-proxy
	# we also increase the limit of decoded frames (up to 50 MB for super high definition videos)
    options = [('grpc.max_receive_message_length', 50 * 1024 * 1024)]
    channel = grpc.insecure_channel('127.0.0.1:50001', options=options)
    stub = video_streaming_pb2_grpc.ImageStub(channel)

    # displaying video info (if exists)
    probe = stub.VideoProbe(gen_buffer_probe_request(device_name=args.device))
    aproxFps = 30 # just a guess
    if probe.buffer:
        aproxFps = probe.buffer.approximate_fps

    print(probe)
    
    # requesting video frames
    req = gen_image_request(device_name=args.device,keyframe_only=args.keyframe)
    while True:
        frame = stub.VideoLatestImage(req)
        # it's good to check if empty frame returned
        if frame is not None:
			# read raw frame data and convert to numpy array
            img_bytes = frame.data 
            re_img = np.frombuffer(img_bytes, dtype=np.uint8)

            # reshape image back into original dimensions
            if len(frame.shape.dim) > 0:
                reshape = tuple([int(dim.size) for dim in frame.shape.dim])
                re_img = np.reshape(re_img, reshape)

                # # display image
                cv2.imshow('box', re_img)
                
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break
        
        # delay by assumed fps rate
        delay = 1 / aproxFps
        time.sleep(delay)
```

Display video at original frame rate for `test` camera:

	python opencv_display.py --device test

Display only Keyframes for `test` camera:

	python opencv_display.py --device test --keyframe


## Code walkthrough

We establish a gRPC connection to Chryslis Edge Proxy which by default runs on :50001 port of locahost:

```python
	# grpc connection to video-edge-ai-proxy
	# we also increase the limit of decoded frames (up to 50 MB for super high definition videos)
    options = [('grpc.max_receive_message_length', 50 * 1024 * 1024)]
    channel = grpc.insecure_channel('127.0.0.1:50001', options=options)
    stub = video_streaming_pb2_grpc.ImageStub(channel)
```

Once we've established the connection we need to create a frame request to be sent to server:

```python
def gen_image_request(device_name, keyframe_only):
    """ Create an object to request a video frame """


    req = video_streaming_pb2.VideoFrameRequest()
    req.device_id = device_name
    req.key_frame_only = keyframe_only
    return req
```

Function accepts 2 parameters (device_name, sometimes referred to as device_id or camera name) and keyframe_only<Bool> requesting only keyframes when True.


In perpetual loop we request video frames for desired camera. It's a simple request, response Unary RPC call.

```python
 	# requesting video frames
    req = gen_image_request(device_name=args.device,keyframe_only=args.keyframe)
    while True:
        frame = stub.VideoLatestImage(req)
        # it's good to check if empty frame returned
        if frame is not None:
			# read raw frame data and convert to numpy array
            img_bytes = frame.data 
            re_img = np.frombuffer(img_bytes, dtype=np.uint8)
```

Returned frame from `VideoLatestImage` contains a `data` attribute. That's where our image is stored as `BGR24` file. Since the data is stored as one dimensional byte buffer we need to convert the image into numpy array. 

After we converted the image into numpy array is easy to reshape that array into a decoded frame dimensions: 

```python
	# reshape image back into original dimensions
    if len(frame.shape.dim) > 0:
    	reshape = tuple([int(dim.size) for dim in frame.shape.dim])
        re_img = np.reshape(re_img, reshape)
```

We end up with BGR24 image ready to be fed into any ML model or displayed with OpenCV as in our case:

```python
	# display image
	cv2.imshow('box', re_img)
```