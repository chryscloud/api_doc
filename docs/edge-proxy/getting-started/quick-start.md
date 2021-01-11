# Quick Start

By default video-edge-ai-proxy requires these ports:

	8905 for web portal
	8909 for RESTful API (portal API)
	50001 for client grpc connection
	6379 for redis

Make sure these ports are available before you start.

## Setup directory

Create a directory under `chrysedgeserver` -> `volumes`:

=== "Linux"
	```/data/chrysalis```

=== "Mac OS X and Windows"
	```/Users/usename/data```

## Compose docker file

Copy and paste below contents into a `docker-compose.yml` file and save it to the folder of your choice, recommended to be different than `/data/chrysalis`:

	version: '3.8'
	services:
	  chrysedgeportal:
	    image: chryscloud/chrysedgeportal:0.0.6
	    depends_on:
	      - chrysedgeserver
	      - redis
	    ports:
	      - "8905:8905"
	    networks:
	      - chrysnet
	  chrysedgeserver:
	    image: chryscloud/chrysedgeserver:0.0.6
	    restart: always
	    depends_on:
	      - redis
	    entrypoint: /app/main
	    ports:
	      - "8909:8909"
	      - "50001:50001"
	    volumes:
	      - /data/chrysalis:/data/chrysalis
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

## Start Video Edge AI Proxy

Run the command:

	docker-compose pull
	docker-compose up -d --no-build

Open browser and visit `chrysalisportal` at address: `http://localhost:8905`
