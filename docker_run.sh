
#! /bin/bash

# DOCKER
DOCKER_IMAGE="egf-ubuntu-22.04:latest"

. dockerbuilder.config

docker run -h dockerbuilder --network=host -it --rm --security-opt seccomp=unconfined \
--mount='type=bind,source='${OUTPUT_SRC}',target='${OUTPUT_DEST} \
--mount='type=bind,source='${INPUT_SRC}',target='${INPUT_DEST} \
--mount='type=bind,source='${DOWNLOADS_SRC}',target='${DOWNLOADS_DEST} \
$SSTATE_MIRROR_BINDMOUNT \
$SITECONF_BINDMOUNT \
$DOCKER_IMAGE $SSTATE_MIRROR_ENABLE
