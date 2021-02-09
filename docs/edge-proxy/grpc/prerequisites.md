# Chrysalis Edge Video API

Access to connected cameras video streams. 

## gRPC 

gRPC can use protocol buffers as both its Interface Definition Language (IDL) and as its underlying message interchange format. If you’re new to gRPC and/or protocol buffers, <u>[read this!](https://grpc.io/docs/what-is-grpc/introduction/)</u>

## Package chrys.cloud.videostreaming.v1beta1

Service overview:

```
service Image {
    rpc VideoLatestImage(stream VideoFrameRequest) returns (stream VideoFrame) {}
    rpc VideoBufferedImage(VideoFrameBufferedRequest) returns (stream VideoFrame) {}
    rpc VideoProbe(VideoProbeRequest) returns (VideoProbeResponse) {}
    rpc ListStreams(ListStreamRequest) returns (stream ListStream) {}
    rpc Annotate(AnnotateRequest) returns (AnnotateResponse) {}
    rpc Proxy(ProxyRequest) returns (ProxyResponse) {} // start stop rtmp passthrough
    rpc Storage(StorageRequest) returns (StorageResponse) {} // start stop storage request on the Chrysalis servers
    rpc SystemTime(SystemTimeRequest) returns (SystemTimeResponse) {} // returns current system time
}
```

To see complete `proto` file <u>[click here](https://github.com/chryscloud/video-edge-ai-proxy/blob/master/proto/video_streaming.proto)</u>

### VideoLatestImage

`VideoLatestImage` is specifically designed to return a decoded image in bgr24 format in sequential order as seen from camera stream. 

It's purpose is to feed the image into any inference ML model for AI insight and video analytics. 

Although it can also be used for display purposes.  

#### Short Q&A

**Q: What if my ML inference engine can't process all frames from live stream?**

*A:*: The API is designed to analize video in real time therefor it will drop all "expired" frames (oldest frames that might overflow the internal queue) and feed only the current frames from camera. The emphasis is on live stream. 

**Q: What is I'd like to be able to process all frames from the camera?**

*A:*: As long as you frequently query this API you should be able to retrieve all frames produced by your camera. This is true as long the internal queue doesn't get full at which point the frame dropping begins. 
If you'd like to "catch-up" on a stream but not drop any frames look into configuring an `in memory buffer` and define it's length in frames. Check also `VideoBufferedImage`

**Q: What if my inference engine is faster than camera produces video frames?**

*A:* The query will wait for maximum of `16*3` milliseconds. If the new frame from the camera doesn't appear it will return empty `Data`. 

**Q: Does VideoLatestImage return duplicate images?**

*A:* No. VideoLatestImage remembers the point in time of the last returned frame. Next query will return new image. 

**Q: Is there a limit on number of queries?**

*A:* No. You can query as fast as you can. Response times are optimized for you to be able to simply query multiple connected cameras also.


#### Proto Messages

The request message for latest decoded video frame from specific camera: `VideoFrameRequest`

Request: `VideoFrameRequest`

| Fields  | |
|-------------| -- |
| device_id | **string**: The name of the camera you've setup in section `Connect RTSP Camera`
| key_frame_only | **string**: Decode only key frames from camera you've setup in section `Connect RTSP Camera`

Response message `VideoFrame`

| Fields  | |
|-------------| -- |
| width | **int64**: the width of the ingested video
| height | **int64**: the height of the ingested video
| data | **bytes**: decoded video frame (**BGR24**)
| is_keyframe | **bool**: If the returned image was decoed from keyframe
| pts | **int64**: decoding timestamp
| dts | **int64**:  presentation timestamp
| frame_type | **string**: I, P, B frame
| is_corrupt | **string**: if decoding produced a corrupt image
| time_base | **double**: decoder use for knowing the time lag between frames
| device_id | **string**: the name of the camera
| packet | **int64**: the packet index
| extradata | **bytes**: custom extra data attached to the frame
| codec_name| **string**: name of the codec used to decode a frame
| pix_fmt | **string**: pixel format of compressed stream


Proto message:
```
message VideoFrame {
    int64 width = 1;
    int64 height = 2;
    bytes data = 3;
    int64 timestamp = 4;
    bool is_keyframe = 5;
    int64 pts = 6;
    int64 dts = 7;
    string frame_type = 8;
    bool is_corrupt = 9;
    double time_base = 10;
    ShapeProto shape = 11;
    string device_id = 12;
    int64 packet = 13;
    int64 keyframe = 14;
    bytes extradata = 15;
    string codec_name = 16;
    string pix_fmt = 17;
}
message VideoFrameRequest {
    bool key_frame_only = 1;
    string device_id = 2;
}

```

### VideoProbe

`VideProbe` returns basic codec information from specific camera. It also attached in-memory buffer information if exists. 

#### Proto Messages


Request: `VideoProbeRequest`

| Fields  | |
|-------------| -- |
| device_id | **string**: The name of the camera you've setup in section `Connect RTSP Camera`

Response: `VideoProbeResponse`

| Fields  | |
|-------------| -- |
| video_codec | **VideoCodec**: basic video information (width, height, ...) 
| buffer | **VideoBuffer**: basic video buffer information


```
message VideoProbeRequest {
    string device_id = 1;
}

message VideoProbeResponse {
    VideoCodec video_codec = 1;
    VideoBuffer buffer = 2;
}
message VideoBuffer {
    int64 start_time = 1;
    int64 end_time = 2;
    int64 duration_seconds = 3;
    int32 approximate_fps = 4;
    int64 frames = 5;
}
// VideoCodec information about the stream
message VideoCodec {
    string name = 1;
    int32 width = 2;
    int32 height = 3;
    string pix_fmt = 4;
    bytes extradata = 5;
    int32 extradata_size = 6;
    string long_name = 7;
}
```

### VideoBufferedImage

`VideoBufferedImage` retrieves video frames from buffer. 

#### Proto Messages

Request: `VideoFrameBufferedRequest`

| Fields  | |
|-------------| -- |
| device_id | **string**: The name of the camera you've setup in section `Connect RTSP Camera`
| timestamp_from | **int64**: Start point in time in the buffer (in milliseconds)
| timestamp_to | **int64**: End point in time in the buffer (in milliseconds)

Response: [`VideoFrame`](#videoframe)


### ListStreams

`ListStream` returns the list of all connected cameras. 

#### Proto Messages

Requires empty request

Request: `ListStreamRequest`

| Fields  | |
|-------------| -- |


Response: `ListStream`

| Fields  | |
|-------------| -- |
| name | **string**: The name of the camera you've setup in section `Connect RTSP Camera`
| status | **string**: running, restarting, failed, stopped
| failing_streak | **int64**: number of failed attempts to connect to camera
| health_status | **string**: *deprecated*
| dead | **bool**: process is dead
| exit_code | **int64**: process exit code 
| pid | **int32**: process PID
| running | **bool**: True if camera is up and running
| paused | **bool**: True if process is paused
| restarting | **bool**: True if process is restarting
| oomkilled | **bool**: True if process is OOM killed
| error | **string**: Failure description

```
// ListStream messages
message ListStream {
    string name = 1;
    string status = 2;
    int64 failing_streak = 3;
    string health_status = 4;
    bool dead = 5;
    int64 exit_code = 6;
    int32 pid = 7;
    bool running = 8;
    bool paused = 9;
    bool restarting = 10;
    bool oomkilled = 11;
    string error = 12;
}
message ListStreamRequest {
}
```

### Annotate

Forwarding annotations to Chrysalis Cloud.

TBD

### Proxy

On/Off switch for forwarding video stream to Chrysalis Cloud for further video analysis in the cloud.

TBD

### Storage

Turning cloud storage on and off. 

TBD

### SystemTime

Chrysalis Edge system time. Addressing possible clock drifts between systems.

TBD



<!-- Create conda environment:

	conda env create -f examples/environment.yml

Activate environment:

	conda activate chrysedgeexamples
	cd examples

Generate python grpc stubs:

	make examples -->
