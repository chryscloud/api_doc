# Chrysalis Clouds' REST APIs

The Chrysalis Clouds' video-edge-ai-proxy server exposes RESTful APIs for stream management. With these APIs you can start, stop, delete, and list the rtmp_to_rtsp containers.

## Connect

This commands lets you connet to a new RTSP camera.

=== "curl"

``` curl

curl -d '{"name":"demo","rtsp_endpoint":"rtsp://igor:igor123456@10.0.1.26/axis-media/media.amp"}' -H "Content-Type:application/json" http://127.0.0.1:8909/api/v1/process
```
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