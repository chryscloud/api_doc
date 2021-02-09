# ListStreams

`ListStream` returns the list of all connected cameras. 

## Proto Messages

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