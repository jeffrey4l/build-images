#!/bin/bash

ME=$0

CUR=$(readlink -f $(dirname $ME))
PROJECT_ROOT=$(dirname $CUR)

ALIYUN_CLI_VERSION=3.0.32
ALIYUN_CLI_FILENAME=aliyun-cli-linux-${ALIYUN_CLI_VERSION}-amd64.tgz
ALIYUN_CLI_URL=https://github.com/aliyun/aliyun-cli/releases/download/v${ALIYUN_CLI_VERSION}/${ALIYUN_CLI_FILENAME}

prepare_environment(){
    apt-get update
    apt-get -y install \
        apt-transport-https \
        bzip2 \
        debootstrap \
        dosfstools \
        gdisk \
        inetutils-ping \
        kpartx \
        kpartx \
        lsb-release \
        python-lzma \
        python-pip \
        qemu-utils \
        qemu-utils \
        rpm \
        sudo \
        util-linux \
        uuid-runtime \
        yum-utils
    pip install -U 'diskimage-builder<2.39'
}

download_aliyun_cli(){

    curl -sSL --write-out "curl (%{url_effective}): response: %{http_code}, time: %{time_total}, size: %{size_download}\n"\
        $ALIYUN_CLI_URL -o $ALIYUN_CLI_FILENAME
    tar xvf ${ALIYUN_CLI_FILENAME}
    cp aliyun /usr/bin/aliyun
    chmod +x /usr/bin/aliyun
}

config_aliyun_cli(){
    aliyun configure set \
        --access-key-id $ACCESS_KEY_ID \
        --access-key-secret $ACCESS_KEY_SECRET \
        --region cn-beijing
}

oss_copy(){
    filename=$1
    aliyun oss rm oss://xcodest/image/$filename
    aliyun oss cp $PROJECT_ROOT/$filename oss://xcodest/image/$filename
}

build_ironic_centos7(){
    bash -x $PROJECT_ROOT/build_ironic_centos7.sh

    oss_copy ironic-centos7.qcow2
    oss_copy ironic-centos7.initrd
    oss_copy ironic-centos7.vmlinuz
}

build_centos7(){
    bash $PROJECT_ROOT/build_centos7.sh

    oss_copy centos7-amd64.qcow2
}

build_centos7-dev(){
    bash $PROJECT_ROOT/build_centos7-dev.sh

    oss_copy centos7-amd64-dev.qcow2
}

prepare_environment
download_aliyun_cli
config_aliyun_cli

$1
