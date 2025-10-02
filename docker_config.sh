#! /bin/bash

# FOLDERS BINDING
OUTPUT_SRC=/yocto/yocto-2023/releases/clienti/lainox/project/yocto-output
INPUT_SRC=/yocto/yocto-2023/releases/clienti/lainox/project/yocto-input
DOWNLOADS_SRC=${DOWNLOADS_SRC:-/yocto/yocto-2023/releases/clienti/lainox/project/downloads}

OUTPUT_DEST=/home/yocto/yocto-output
INPUT_DEST=/home/yocto/yocto-input
DOWNLOADS_DEST=/home/yocto/downloads
SSTATE_MIRROR_DEST=/home/yocto/sstate-mirror
SITENCONF_DEST=/home/yocto/.yocto

SSTATE_MIRROR_BINDMOUNT=
SSTATE_MIRROR_ENABLE=
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

cat << EOF > dockerbuilder.config
OUTPUT_SRC="${OUTPUT_SRC}"
INPUT_SRC="${INPUT_SRC}"
DOWNLOADS_SRC="${DOWNLOADS_SRC}"

OUTPUT_DEST="${OUTPUT_DEST}"
INPUT_DEST="${INPUT_DEST}"
DOWNLOADS_DEST="${DOWNLOADS_DEST}"

SSTATE_MIRROR_BINDMOUNT="${SSTATE_MIRROR_BINDMOUNT}"
SSTATE_MIRROR_ENABLE="${SSTATE_MIRROR_ENABLE}"
SITECONF_BINDMOUNT="${SITECONF_BINDMOUNT}"
EOF
