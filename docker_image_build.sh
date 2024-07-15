#! /bin/bash

# DOCKER
DOCKER_IMAGE="egf-ubuntu-22.04:latest"

CMD="docker build"
CMD+=' -f Dockerfile --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --tag "'
CMD+=$DOCKER_IMAGE
CMD+='" .'

eval $CMD



