# Building from source

### Clone repository

Clone the Chrysalis Cloud video-edge-ai-proxy repo from guthub:

	git clone https://github.com/chryscloud/video-edge-ai-proxy.git

The video-edge-ai-proxy stores running processes, one for each connected camera, into a local datastore hosted on your file system. By default the folder path used is:

- `/data/chrysalis` 

create this folder if it doesn't exist and make sure it's writable by docker process.

### Docker run

In case you cloned this repository you can run docker-compose with build command. `Start video-edge-ai-proxy with local build:`

	docker-compose up -d

or

	docker-compose build