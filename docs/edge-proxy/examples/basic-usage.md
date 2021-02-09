# Listing connected cameras

This example displays all connected cameras to Chrysalis Edge. 

It's a simple request, response Unary RPC call.


`list_streams.py:`

```python
import grpc
import video_streaming_pb2_grpc, video_streaming_pb2
import argparse


def send_list_stream_request(stub):
    """ Create a list of streams request object """


    stream_request = video_streaming_pb2.ListStreamRequest()   
    responses = stub.ListStreams(stream_request)
    for stream_resp in responses:
        yield stream_resp

if __name__ == "__main__":
	# grpc connection to video-edge-ai-proxy
    options = [('grpc.max_receive_message_length', 50 * 1024 * 1024)] # 50 MB max single response
    channel = grpc.insecure_channel('127.0.0.1:50001', options=options)
    stub = video_streaming_pb2_grpc.ImageStub(channel)

	# send request
	list_streams = send_list_stream_request(stub)
        for stream in list_streams:
            print(stream)
```

List all stream processes:

	python list_streams.py

Successful output example:

	name: "test"
	status: "running"
	pid: 18109
	running: true
