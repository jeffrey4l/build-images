#!/bin/bash
export DIB_IMAGE_SIZE=2

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

export FS_TYPE=xfs

disk-image-create -a amd64 -o ironic-centos7 -t qcow2 \
    baremetal \
    centos7 \
    dhcp-all-interfaces \
    disable-selinux \
    disable-update-hostname \
    dracut-regenerate \
    dynamic-login \
    element-manifest \
    grub2 \
    manifests \
    openssh-config \
    openssh-server \
    rpm-distro \
    stable-interface-names \
    sysprep
