# Python Examples prerequisites

<u>[Install Anaconda environment](https://docs.anaconda.com/anaconda/install/)</u>

All examples including the Anaconda environment descriptors can be found here: [https://github.com/chryscloud/video-edge-ai-proxy/tree/master/examples](https://github.com/chryscloud/video-edge-ai-proxy/tree/master/examples)

## Create Anaconda environment

You can use this `environment.yml` descriptor for all documented examples:

```
name: chrysedgeexamples
channels:
  - conda-forge
  - peper0
dependencies:
  - python=3.7.7
  - numpy=1.18.1
  - pip=20.0.2
  - opencv=4.4.0
  - pip:
    - grpcio
    - grpcio-tools
    - imutils
```

Create environment:

```
conda create -f environment.yml
```

Activate environment:

```
conda activate chrysedgeexamples
```

## Build gRPC Client service

<u>[Download proto file from here and put proto subfolder](https://github.com/chryscloud/video-edge-ai-proxy/blob/master/proto/video_streaming.proto)</u>

Build python client stubs:

```
python3 -m grpc_tools.protoc -I proto/ --python_out=examples/ --grpc_python_out=examples/ proto/video_streaming.proto
```

This should create 2 additional files in your "examples" folder: `video_streaming_pb2.py` and `video_streaming_pb2_grpc.py`

You're ready to run some examples now!

