
#! /bin/bash

# DOCKER
DOCKER_IMAGE="egf-ubuntu-22.04:latest"

# FOLDERS BINDING
OUTPUT_SRC=${PROG_DIR}/yocto-output
INPUT_SRC=${PROG_DIR}/yocto-input
DOWNLOADS_SRC=${DOWNLOADS_SRC:-${PROG_DIR}/downloads}

OUTPUT_DEST=/home/yocto/yocto-output
INPUT_DEST=/home/yocto/yocto-input
DOWNLOADS_DEST=/home/yocto/downloads
SSTATE_MIRROR_DEST=/home/yocto/sstate-mirror
SITENCONF_DEST=/home/yocto/.yocto

SSTATE_MIRROR_BINDMOUNT=
SSTATE_MIRROR_CREATECONFIG=
SITECONF_BINDMOUNT=

if [ -n $SSTATE_MIRRORS_SRC ]
then
       SSTATE_MIRROR_BINDMOUNT="--mount=type=bind,source=${SSTATE_MIRRORS_SRC},target=${SSTATE_MIRROR_DEST}"
       SSTATE_MIRROR_ENABLE="/home/yocto/enable_sstate_mirror.sh ${SSTATE_MIRROR_DEST}"
fi

if [ -n $SITECONF_SRC ]
then
       SITECONF_BINDMOUNT="--mount=type=bind,source=${SITECONF_SRC},target=${SITENCONF_DEST}"
fi

docker run -h dockerbuilder --network=host -it --rm --security-opt seccomp=unconfined \
--mount='type=bind,source='${OUTPUT_SRC}',target='${OUTPUT_DEST} \
--mount='type=bind,source='${INPUT_SRC}',target='${INPUT_DEST} \
--mount='type=bind,source='${DOWNLOADS_SRC}',target='${DOWNLOADS_DEST} \
$SSTATE_MIRROR_BINDMOUNT \
$SITECONF_BINDMOUNT \
$DOCKER_IMAGE $SSTATE_MIRROR_ENABLE
