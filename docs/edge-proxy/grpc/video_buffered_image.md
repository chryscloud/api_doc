# VideoBufferedImage

`VideoBufferedImage` retrieves video frames from buffer. 

It works well in conjunction with VideoProbe which outputs information on the in memory buffer details. 

## Proto Messages

Request: `VideoFrameBufferedRequest`

| Fields  | |
|-------------| -- |
| device_id | **string**: The name of the camera you've setup in section `Connect RTSP Camera`
| timestamp_from | **int64**: Start point in time in the buffer (in milliseconds)
| timestamp_to | **int64**: End point in time in the buffer (in milliseconds)

Response: <u>[`VideoFrame`](../video_latest_image#videoprobe)</u>
