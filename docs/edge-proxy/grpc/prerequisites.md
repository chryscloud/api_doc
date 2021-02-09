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

## Index




<!-- Create conda environment:

	conda env create -f examples/environment.yml

Activate environment:

	conda activate chrysedgeexamples
	cd examples

Generate python grpc stubs:

	make examples -->
