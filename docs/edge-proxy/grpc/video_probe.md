# VideoProbe

`VideProbe` returns basic codec information from specific camera. It also attached in-memory buffer information if exists. 

## Proto Messages


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