#! /bin/bash

cd ${YOCTO_INPUT_DIR}/sources/meta-egf 
./scripts/egf-setup.sh
cd ../../
source ./setup_build.sh
bitbake ${YOCTO_DISTRO_IMAGE_NAME}
bitbake ${YOCTO_DISTRO_IMAGE_NAME} -c populate_sdk
/bin/bash