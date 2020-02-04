#!/bin/bash
export DIB_IMAGE_SIZE=2

export ELEMENTS_PATH=elements
#export TMP_BUILD_DIR=/data/dib

#export DIB_CLOUD_IMAGES=http://images.trystack.cn/centos
#export BASE_IMAGE_FILE=CentOS-7-x86_64-GenericCloud.qcow2.xz
export DIB_DISTRIBUTION_MIRROR=http://mirrors.aliyun.com/centos
export DIB_CLOUD_INIT_DATASOURCES="ConfigDrive, OpenStack, Ec2"
export DIB_EPEL_MIRROR=http://mirrors.aliyun.com/epel

export DIB_CLOUD_INIT_ALLOW_SSH_PWAUTH=1
export DIB_CLOUD_INIT_ENABLE_ROOT=1

export FS_TYPE=xfs

disk-image-create -a amd64 -o centos7-amd64 -t qcow2 "$@" \
    centos7 \
    disable-selinux \
    epel \
    cloud-init \
    cloud-init-datasources \
    dynamic-login\
    element-manifest \
    dhcp-all-interfaces \
    vm \
    qemu-guest-agent \
    disable-update-hostname \
    timezone \
    openssh-config \
    auto-fstrim
