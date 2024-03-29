#!/bin/bash

_ARCH=$(uname -m)

case $_ARCH in
  "x86_64")
    _ARCH="amd64"
    ;;
  "aarch64")
    _ARCH="arm64"
    ELEMENTS="block-device-efi"
    ;;
esac

export DIB_IMAGE_SIZE=4

export ELEMENTS_PATH=elements


# 18.04 bionic
# 20.04 focal
export DIB_RELEASE=${DIB_RELEASE:-bionic}

export DIB_CLOUD_IMAGES=http://mirrors.ustc.edu.cn/ubuntu-cloud-images/$DIB_RELEASE/current/
#export DIB_DISTRIBUTION_MIRROR=http://mirrors.ustc.edu.cn/ubuntu-cloud-images

export DIB_CLOUD_INIT_DATASOURCES="ConfigDrive, OpenStack, Ec2"

export DIB_CLOUD_INIT_ALLOW_SSH_PWAUTH=1
export DIB_CLOUD_INIT_ENABLE_ROOT=1

# ISSUE LIST:
# * dhcp-all-interface not work.  seems cloud-init is doing more in interface management
# * mirror url do not work. cloud-init override it, need change cloud.cfg file

disk-image-create -a $_ARCH -o ubuntu-${DIB_RELEASE} "$@" \
    ubuntu \
    cloud-init \
    cloud-init-datasources \
    dynamic-login \
    element-manifest \
    dhcp-all-interfaces \
    vm \
    qemu-guest-agent \
    disable-update-hostname \
    block-device-gpt \
    timezone \
    openssh-config \
    auto-fstrim  $ELEMENTS
