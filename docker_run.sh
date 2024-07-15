
#! /bin/bash

# DOCKER
DOCKER_IMAGE="egf-ubuntu-22.04:latest"

# FOLDERS BINDING
OUTPUT_SRC=${PROG_DIR}/yocto-output
INPUT_SRC=${PROG_DIR}/yocto-input
DOWNLOADS_SRC=${PROG_DIR}/downloads

OUTPUT_DEST=/home/yocto/yocto-output
INPUT_DEST=/home/yocto/yocto-input
DOWNLOADS_DEST=/home/yocto/downloads

docker run -h dockerbuilder --network=host -it --rm --security-opt seccomp=unconfined \
--mount='type=bind,source='${OUTPUT_SRC}',target='${OUTPUT_DEST} \
--mount='type=bind,source='${INPUT_SRC}',target='${INPUT_DEST} \
--mount='type=bind,source='${DOWNLOADS_SRC}',target='${DOWNLOADS_DEST} $DOCKER_IMAGE
