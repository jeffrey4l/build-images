#!/bin/bash
export DIB_IMAGE_SIZE=3

export ELEMENTS_PATH=elements
#export TMP_BUILD_DIR=/data/dib

#export DIB_CLOUD_IMAGES=http://images.trystack.cn/centos
#export BASE_IMAGE_FILE=CentOS-7-x86_64-GenericCloud.qcow2.xz
export DIB_DISTRIBUTION_MIRROR=http://mirrors.aliyun.com/centos
# Only support ConfigDrive which is faster
export DIB_CLOUD_INIT_DATASOURCES="ConfigDrive"
export DIB_EPEL_MIRROR=http://mirrors.aliyun.com/epel

export DIB_CLOUD_INIT_ALLOW_SSH_PWAUTH=1
export DIB_CLOUD_INIT_ENABLE_ROOT=1

export DIB_DEV_USER_USERNAME=admin
export DIB_DEV_USER_PASSWORD=pass
export DIB_DEV_USER_PWDLESS_SUDO=1

export FS_TYPE=xfs

disk-image-create -a amd64 -o centos7-amd64-dev -t qcow2 "$@" \
    auto-fstrim \
    centos7 \
    cloud-init \
    cloud-init-datasources \
    custom-packages \
    devuser \
    dhcp-all-interfaces \
    disable-selinux \
    element-manifest \
    epel \
    openssh-config \
    qemu-guest-agent \
    block-device-gpt \
    timezone \
    kernel-rt \
    vm
