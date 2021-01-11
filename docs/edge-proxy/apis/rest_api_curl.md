# Chrysalis Clouds' REST APIs

The Chrysalis Clouds' video-edge-ai-proxy server exposes RESTful APIs for stream management. With these APIs you can start, stop, delete, and list the rtmp_to_rtsp containers.

## Connect

This commands lets you connet to a new RTSP camera.

=== "curl"

``` curl

curl -d '{"name":"demo","rtsp_endpoint":"rtsp://igor:igor123456@10.0.1.26/axis-media/media.amp"}' -H "Content-Type:application/json" http://127.0.0.1:8909/api/v1/process
```

## Get process

This command will return the details of a single RTSP camera process

=== "curl"

```curl
curl http://127.0.0.1:8909/api/v1/process/{processName}
```

#### Path Parameters

| Parameters  | |
|-------------| -- |
| processName | **string** The name of the RTSP process. For example: `demo`

#### Response Body

```json
{
   "container_id" : "d8e821530a1841db8aa29830bba1849b95fdedbc255b0ee2063f225cf7ce2425",
   "created" : 1610394856000,
   "image_tag" : "chryscloud/chrysedgeproxy:0.0.6",
   "logs" : {
      "stderr" : null,
      "stdout" : "QXJjaG..."
   },
   "modified" : 1610394893000,
   "name" : "demo",
   "rtmp_stream_status" : {
      "storing" : false,
      "streaming" : true
   },
   "rtsp_endpoint" : "rtsp://igor:igor123456@10.0.1.26/axis-media/media.amp",
   "state" : {
      "Dead" : false,
      "Error" : "",
      "ExitCode" : 0,
      "FinishedAt" : "0001-01-01T00:00:00Z",
      "OOMKilled" : false,
      "Paused" : false,
      "Pid" : 122478,
      "Restarting" : false,
      "Running" : true,
      "StartedAt" : "2021-01-11T19:54:16.01726981Z",
      "Status" : "running"
   },
   "status" : "running",
   "upgrade_available" : false
}

```

| Fields  | |
|-------------| -- |
| container_id | **string**: The id of the tunning docker container
| created | **int64**: milliseconds since epoch this process was created
| image_tag | **string**: name of the docker image for the current process
| logs | [Logs](#logs)
| modified | **int64**: milliseconds since epoch of the last modification to this process
| name | **string**: name of the process
| rtmp_stream_status | [RtmpStreamStatus](#rtmpstreamstatus)
| rtsp_endpoint | **string**: full connection string for the RTSP camera
| status | **string**: the status of the process: `running`, `paused`, `oomkilled`, `restarting`,`created`
| upgrade_available | **bool**: If the new version for this process is available

#### Logs
| Field | |
| ------| -- |
| stderr | **base64**: base64 encoded standard output errors from the process
| stdout | **base64**: base64 encoded standard output from the process

#### RtmpStreamStatus
| Field | |
| ------| -- |
| storing | **bool**: if the current process is storing the video stream in the cloud
| streaming | **bool**: if the current process is proxying the video stream to the cloud



## Delete

This command lets you delete a RTSP camera. 

=== "curl"

```curl 
curl -X DELETE http://127.0.0.1:8909/api/v1/process/demo
```
## List

This command lists all the RTSP cameras. 

=== "curl"
``` curl
curl http://127.0.0.1:8909/api/v1/processlist
```