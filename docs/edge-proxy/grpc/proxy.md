# Proxy

On/Off switch for forwarding video stream to Chrysalis Cloud for further video analysis in the cloud.

## Proto Messages

Request:`ProxyRequest`

| Fields  | |
|-------------| -- |
| device_id | **string**: required: The name of the camera you've setup in section `Connect RTSP Camera`
| passthrough | **bool**: true = passthrough streaming, false = stop passthrough streaming

Response: `ProxyResponse`

| Fields  | |
|-------------| -- |
| device_id | **string**: required: The name of the camera you've setup in section `Connect RTSP Camera`
| passthrough | **bool**: true = passthrough streaming, false = stop passthrough streaming



```
// Proxy messages
message ProxyRequest {
    string device_id = 1;
    bool passthrough = 2; // true = passthrough streaming, false = stop passthrough streaming
}

message ProxyResponse {
    string device_id = 1;
    bool passthrough = 2;
}
```