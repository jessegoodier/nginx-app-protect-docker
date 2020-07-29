#!/bin/bash
set -e

docker build --tag=nginx-app-protect .

#check if container exists and remove if so
if [ -n "$( docker container ls --all --quiet --filter name=^/nginx-app-protect$ )" ]; then
  echo "Container exists, removing"
  docker rm -f nginx-app-protect;
fi

#pass the ports and volumes, run interactively to view log output, this is a demo
docker run --rm -it -p 80:80 --name=nginx-app-protect nginx-app-protect:latest

