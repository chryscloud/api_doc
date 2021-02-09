# Chrysalis Cloud Video-Edge-AI-Proxy

The ultimate video pipeline for Computer Vision. The video-edge-ai-proxy ingests multiple RTSP camera streams and provides a common interface for conducting AI operations on or near the Edge.

![Placeholder](https://camo.githubusercontent.com/a9c6aba1cf4a661b1f08da236bddc6bc47df2a49a0947f8623e4e34e813f704a/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f6368727973616c69737765626173736574732f6368727973616c69732d766964656f2d656467652d61692d70726f78792e706e67){: loading=lazy }

The video-edge-ai-proxy is an easy to use collection mechanism from multiple cameras onto a single more powerful computer. 

For example, a network of CCTV RTSP enabled cameras can be accessed through a simple GRPC interface, where Machine Learning algorithms can do various Computer Vision tasks. 

Furthermore, interesting footage can be annotated, selectively streamed and stored through a simple API for later analysis, computer vision tasks in the cloud or enriching the Machine Learning training samples.


# Features

Build with AI inference in mind.

|  Basic Features | |
|-------------| -- |
| **Camera HUB** | User interface and RESTful API for setting up multiple RTSP cameras
| **Connection management** | Handles cases of network fluctuations or camera streaming problems
| **Stream management** | Deals with the complexities of compressed video streams so you don't have to
| **Video/Image Hub** | Processing multiple camera sources simultaneously
| **Flexibility** | Can support other than RTSP cameras

|  Connection to Cloud | |
|-------------| -- |
| **Selective Pass-Through** | Preserving bandwidth by choosing when to forward a portion of a stream to the cloud
| **Storage optimizer** | Minimizing video by selecting which portions of stream to store in the cloud
| **AI Annotation** | Asynchronous annotations to the cloud