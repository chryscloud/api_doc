# Docker Playbook

## How to show Chrys Edge logs

```
sudo docker-compose logs
```

## How to stop / restart Chrys Edge

```python

#Go to the directory you ran install script (where your docker-compose.yml file is)

#  Stop container
sudo docker-compose down

# Stop all docker container
sudo docker stop $(sudo docker ps -aq)

# If docker (and chrys edge) doesn't start at startup enable it
sudo systemctl enable docker

# Start container
# detached mode
sudo docker-compose up -d
# interactive mode
sudo docker-compose up

# Restart container (after modifying the cong.yaml file for example)
sudo docker-compose restart

# Clear all docker container, images ...
sudo docker system prune -a

# Restart docker
sudo service docker restart
```

## How to update Chrys Edge Version

When newer version are available you can change the versions in the `docker-compose.yml` file and issue pull command:

```
sudo docker-compose pull
```

Alternatively you can repeat the installation process:

```
curl -O https://raw.githubusercontent.com/chryscloud/api_doc/master/install-chrysedge.sh

# Give exec permission
chmod 777 install-chrysedge.sh

# run installation script
./install-chrysedge.sh
```