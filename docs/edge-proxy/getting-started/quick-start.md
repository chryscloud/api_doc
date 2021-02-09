# Quick Start

By default video-edge-ai-proxy requires these ports:

	8905 for web portal
	8909 for RESTful API (portal API)
	50001 for client grpc connection
	6379 for redis

Make sure these ports are available before you start.

## Download installation script

```
curl -O https://raw.githubusercontent.com/chryscloud/api_doc/master/install-chrysedge.sh

# Give exec permission
chmod 777 install-chrysedge.sh

# run installation script
./install-chrysedge.sh
```

Windows users should skip to `Manual installation`. 

## Use Chrys Edge Proxy

Start the docker images:

```python
docker-compose up

# or to run it in daemon mode:

docker-compose up -d
```

Open browser and visit: `http://localhost:8905`

Next step: <u>[Connect RTSP Camera](portal-usage.md)</u>

## Manual installation

It's recommended to create a folder where your user has sufficient permission. The recommended folder structure is:

```
/home/yourusername/chrysedge
|_/data
|_/videos
```

where `data` and `videos` are subfolders of `chrysedge`

Copy and paste below contents into a `docker-compose.yml` file and save it to `/home/yourusername/chrysedge`:

	version: '3.8'
	services:
	  chrysedgeportal:
	    image: chryscloud/chrysedgeportal:0.0.7.3
	    depends_on:
	      - chrysedgeserver
	      - redis
	    ports:
	      - "8905:8905"
	    networks:
	      - chrysnet
	  chrysedgeserver:
	    image: chryscloud/chrysedgeserver:0.0.7.3
	    restart: always
	    depends_on:
	      - redis
	    entrypoint: /app/main
	    ports:
	      - "8909:8909"
	      - "50001:50001"
	    volumes:
	      - TO_REPLACE_PATH_TO_USER_FOLDER:/data/chrysalis
	      - /var/run/docker.sock:/var/run/docker.sock
	    networks: 
	      - chrysnet
	  redis:
	    image: "redis:alpine"
	    ports:
	      - "6379:6379"
	  
	    networks: 
	      - chrysnet
	networks:
	  chrysnet:
	    name: chrysnet

Change the folder `TO_REPLACE_PATH_TO_USER_FOLDER` with `/home/yourusername/chrysedge`


