# Portal Usage

Open your browser and visit : `http://localhost:8905`

On the first visit, Edge Proxy will display a RTSP docker container icon. Click on it. This will initiate the pull for the latest version of the docker container pre-compiled to be used with RTSP enabled cameras.

## Connecting RTSP camera

* Click: Connect RTSP Camera in the Chrysalis portal and name the camera
* Insert full RTSP link and if credentials are required add them to the link

## Example RTSP url 

=== "With credentials"
	```rtsp://admin:12345@192.168.1.21/Streaming/Channels/101```

=== "Without credentials"
	```rtsp://192.168.1.21:8554/unicast```

Click on the newly created connection and check the output and error log. Expected state is running and the output message `Started python rtsp process...`

## Chrysalis Portal 

![Placeholder](https://camo.githubusercontent.com/25ecc01724287922eeee76e2904575f7d1afc102cc99fe225315b9da7118aab4/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f6368727973616c69737765626173736574732f63687279735f656467655f70726f78795f746573745f63616d2e706e67){: loading=lazy }

## Client Usage

At this point you should have the video-edge-ai-proxy up and running and your first connection to RTSP camera established.