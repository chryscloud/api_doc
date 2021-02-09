# Prerequisites

Before running and deploying this quickstart, install the `Docker` and `docker-compose` command:

- <u>[Install Docker of your operating system][1]</u>

- <u>[Install docker-compose on your operating system][2]</u>

## Enable docker TCP socket connection

If you are running on Mac OS X or Windows use the latest version of  docker-compose and docker.

=== "Linux"

	Create `daemon.json` file in `etc/docker` folder with JSON contents:
	```
	{
	  "hosts": [
	    "fd://",
	    "unix:///var/run/docker.sock"
	  ]
	}
	```

	If you're running `Nvidia's docker containers` make sure you don't remove the nvidia runtime:
	```
	{
   		"hosts": [
    	"fd://",
    	"unix:///var/run/docker.sock"
   		],
    	"runtimes": {
        	"nvidia": {
            	"path": "nvidia-container-runtime",
            	"runtimeArgs": []
        	}
    	}
	}
	```

	Create a new file `/etc/systemd/system/docker.service.d/docker.conf` with the following contents:
	```
	[Service]
	ExecStart=
	ExecStart=/usr/bin/dockerd
	```

	Reload daemon:

	`sudo systemctl daemon-reload`

	Restart docker:

	`sudo service docker restart`

=== "Windows on WSL 2"
	
	It's recommended to download <u>[Docker Desktop Stable 2.3.0.2][3]</u> or a later release 

	Windows specific requirements:

	- Install Windows 10, version 1903 or higher.
	- Enable WSL 2 feature on Windows. For detailed instructions, refer to the Microsoft documentation.
	- Download and install the Linux kernel update package.

=== "Mac OS X"
	Follow the instructions for install docker engine:

	- <u>[Docker Engine installation][4]</u>
	- <u>[Docker Compose installation][5]</u>

=== "Raspberry PI"
	TBD

=== "Nvidia Jetson"
	TBD

  [1]: https://docs.docker.com/engine/install/
  [2]: https://docs.docker.com/compose/install/
  [3]: https://hub.docker.com/editions/community/docker-ce-desktop-windows/
  [4]: https://docs.docker.com/engine/install/
  [5]: https://docs.docker.com/compose/install/