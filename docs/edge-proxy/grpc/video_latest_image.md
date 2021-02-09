# VideoLatestImage

`VideoLatestImage` is specifically designed to return a decoded image in bgr24 format in sequential order as seen from camera stream. 

It's purpose is to feed the image into any inference ML model for AI insight and video analytics. 

Although it can also be used for display purposes.  

## Short Q&A

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


## Proto Messages

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