
# Use Ubuntu 22.04 LTS as the basis for the Docker image.
FROM ubuntu:22.04

# Install all the Linux packages
ENV TZ=Europe/Rome
ENV DEBIAN_FRONTEND noninteractive

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update
RUN apt-get -y install gawk
RUN apt-get -y install wget
RUN apt-get -y install git
RUN apt-get -y install diffstat
RUN apt-get -y install unzip
RUN apt-get -y install texinfo
RUN apt-get -y install gcc-multilib
RUN apt-get -y install build-essential
RUN apt-get -y install chrpath
RUN apt-get -y install socat
RUN apt-get -y install cpio
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN apt-get -y install python3-pexpect
RUN apt-get -y install xz-utils
RUN apt-get -y install debianutils
RUN apt-get -y install iputils-ping
RUN apt-get -y install libsdl1.2-dev
RUN apt-get -y install xterm
RUN apt-get -y install libyaml-dev
RUN apt-get -y install libssl-dev
RUN apt-get -y install python3-git
RUN apt-get -y install python3-jinja2
RUN apt-get -y install tar
RUN apt-get -y install locales
RUN apt-get -y install curl
RUN apt-get -y install openssh-client
RUN apt-get -y install sudo
RUN apt-get -y install nano
RUN apt-get -y install vim
RUN apt-get -y install libegl1-mesa
RUN apt-get -y install rsync
RUN apt-get -y install bc
RUN apt-get -y install linux-headers-generic
RUN apt-get -y install apt-transport-https
RUN apt-get -y install ca-certificates
RUN apt-get -y install ftp
RUN apt-get -y install autoconf
RUN apt-get -y install libtool
RUN apt-get -y install libglib2.0-dev
RUN apt-get -y install libarchive-dev
RUN apt-get -y install sed
RUN apt-get -y install cvs
RUN apt-get -y install subversion
RUN apt-get -y install coreutils
RUN apt-get -y install texi2html
RUN apt-get -y install docbook-utils
RUN apt-get -y install help2man
RUN apt-get -y install make
RUN apt-get -y install gcc
RUN apt-get -y install g++
RUN apt-get -y install desktop-file-utils
RUN apt-get -y install libgl1-mesa-dev
RUN apt-get -y install libglu1-mesa-dev
RUN apt-get -y install mercurial
RUN apt-get -y install automake
RUN apt-get -y install groff
RUN apt-get -y install curl
RUN apt-get -y install lzop
RUN apt-get -y install asciidoc
RUN apt-get -y install u-boot-tools
RUN apt-get -y install dos2unix
RUN apt-get -y install mtd-utils
RUN apt-get -y install pv
RUN apt-get -y install libncurses5
RUN apt-get -y install libncurses5-dev
RUN apt-get -y install libncursesw5-dev
RUN apt-get -y install libelf-dev
RUN apt-get -y install zlib1g-dev
RUN apt-get -y install bc
RUN apt-get -y install rename
RUN apt-get -y install zstd
RUN apt-get -y install libgnutls28-dev
RUN apt-get -y install python3-git zstd liblz4-tool
RUN apt-get -y install python-is-python3
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get -y update
RUN apt-get -y install python3.9

#sudo apt update
#sudo apt-get install apt-transport-https ca-certificates -y
#sudo update-ca-certificates


# By default, Ubuntu uses dash as an alias for sh. Dash does not support the source command
# needed for setting up the build environment in CMD. Use bash as an alias for sh.
RUN rm /bin/sh && ln -s bash /bin/sh

# Set the locale to en_US.UTF-8, because the Yocto build fails without any locale set.
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV USER_NAME yocto

# The running container writes all the build artefacts to a host directory (outside the container).
# The container can only write files to host directories, if it uses the same user ID and
# group ID owning the host directories. The HOST_UID and group_uid are passed to the docker build
# command with the --build-arg option. By default, they are both 1000. The docker image creates
# a group with HOST_GID and a user with HOST_UID and adds the user to the group. The symbolic
# name of the group and user is yocto.
ARG host_uid
ARG host_gid
RUN groupadd -g ${host_gid} $USER_NAME && useradd -g ${host_gid} -m -s /bin/bash -u ${host_uid} $USER_NAME

#add USER_NAME to sudo
RUN echo "$USER_NAME:$USER_NAME" | chpasswd && adduser $USER_NAME sudo

# By default, docker runs as root. However, Yocto builds should not be run as root, but as a 
# normal user. Hence, we switch to the newly created user.
USER $USER_NAME

# Create the directory structure for the Yocto build in the container. The lowest two directory
# levels must be the same as on the host.
ENV BUILD_INPUT_DIR /home/$USER_NAME
ENV BUILD_DOWNLOADS_DIR /home/$USER_NAME/downloads
ENV BUILD_OUTPUT_DIR /home/$USER_NAME/yocto-output
ENV YOCTO_INPUT_DIR /home/$USER_NAME/yocto-input
RUN mkdir -p $BUILD_INPUT_DIR $BUILD_OUTPUT_DIR $BUILD_DOWNLOADS_DIR

ENV SSTATE_MIRROR_DIR /home/$USER_NAME/sstate-mirror
RUN mkdir -p $SSTATE_MIRROR_DIR
RUN mkdir /home/$USER_NAME/.yocto
COPY enable_sstate_mirror.sh /home/$USER_NAME

WORKDIR $YOCTO_INPUT_DIR

SHELL ["/bin/bash", "-c"]

