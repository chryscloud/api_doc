# Prerequisites

## Install Docker Engine
[Docker][1]

## Install Docker Compose
[Docker Compose][2]

## Enable docker TCP socket connection
This setting is required only for Linux based systems. If you are running on Mac OS X or Windows use the latest version of  docker-compose and docker.

Create `daemon.json` file in `etc/docker` folder with JSON contents:

	{
	  "hosts": [
	    "fd://",
	    "unix:///var/run/docker.sock"
	  ]
	}
Create a new file `/etc/systemd/system/docker.service.d/docker.conf` with the following contents:

	[Service]
	ExecStart=
	ExecStart=/usr/bin/dockerd

Reload daemon:

	sudo systemctl daemon-reload

Restart docker:

	sudo service docker restart

You can test out if the configuration is correct by issuing curl request docker socket:

	curl -s --unix-socket /var/run/docker.sock http://dummy/images/json | jq '.'

  [1]: https://docs.docker.com/engine/install/
  [2]: https://docs.docker.com/compose/install/