# Connect your first RTSP Camera

Open your browser and visit : `http://localhost:8905`

On the first visit, Edge Proxy will display a RTSP docker container icon. Click on it. This will initiate the pull for the latest version of the docker container pre-compiled to be used with RTSP enabled cameras.

## Connecting RTSP camera

![ConnectRTSP](https://storage.googleapis.com/chrysaliswebassets/docs/images/add_rtsp_cam.png)
{: loading=lazy }

- Name of the RTSP camera must be all ASCII letters
- Add your IP camera URL

=== "Example With credentials"
	```rtsp://admin:12345@192.168.1.21/Streaming/Channels/101```

=== "Example Without credentials"
	```rtsp://192.168.1.21:8554/unicast```

- Click Add

## Chrysalis Portal 

You should see a similar image as bellow. The left black box is a log. Currently you need to manually refresh the website in order to see the log changes. 

The black box on the right is the error log. If there are no error logs the camera is succesfully connected.

![Placeholder](https://camo.githubusercontent.com/25ecc01724287922eeee76e2904575f7d1afc102cc99fe225315b9da7118aab4/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f6368727973616c69737765626173736574732f63687279735f656467655f70726f78795f746573745f63616d2e706e67){: loading=lazy }

Next step <u>[Video API](../examples/prerequisites.md)</u>