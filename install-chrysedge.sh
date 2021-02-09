#!/bin/bash

# exit when any command fails
set -e

echo "Installing Chryscloud Edge docker images"
command -v docker-compose >/dev/null 2>&1 || { echo >&2 "Chrysalis Edge requires docker-compose, please install and retry"; }

DIR=$(pwd)
mkdir data
mkdir videos


# Get the docker compose file
# wget -N https://raw.githubusercontent.com/docker-compose.yml

# Replace in config.json with default params for the current platform
sed -i'.bak' -e "s/TO_REPLACE_PATH_TO_USER_FOLDER/$DIR/g" docker-compose.yml

