# Remote Storage

Turning cloud storage on and off for a specific device/camera. If storage is ON, then the stream is being forwarded to the Chrysalis Cloud where it's being stored. 

## Proto Messages

Request: `StorageRequest`

| Fields  | |
|-------------| -- |
| device_id | **string**: required: The name of the camera you've setup in section `Connect RTSP Camera`
| start | **bool**: true = start storing the stream, false = stop storing the stream

Response: `StorageResponse`

| Fields  | |
|-------------| -- |
| device_id | **string**: required: The name of the camera you've setup in section `Connect RTSP Camera`
| start | **bool**: true = start storing the stream, false = stop storing the stream


// Storage messages
message StorageRequest {
    string device_id = 1;
    bool start = 2;
}
message StorageResponse {
    string device_id = 1;
    bool start = 2;
}