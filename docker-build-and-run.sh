#!/bin/bash
set -e

docker build --tag=nginx-app-protect .

#check if container exists and remove if so
if [ -n "$( docker container ls --all --quiet --filter name=nginx-app-protect )" ]; then
  echo "Container exists, removing"
  docker rm -f nginx-app-protect;
fi

#pass the ports and volumes, run interactively to view log output, this is a demo
docker run --rm -it -p 80:80 -p 443:443 -p 8080:8080 --add-host syslog:3.20.98.115 --volume $PWD/etc/nginx:/etc/nginx --name=nginx-app-protect nginx-app-protect:latest

