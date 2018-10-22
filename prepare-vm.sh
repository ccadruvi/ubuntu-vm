#!/usr/bin/env bash

set -e -o pipefail

apt-get update
apt-get install -y vim jq git npm
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk

# Manual step to configure gcloud
# gcloud init

# To make gsutil work, BOTO_CONFIG has to be set, see also https://stackoverflow.com/questions/38783140/importerror-no-module-named-google-compute-engine
export BOTO_CONFIG=/dev/null


# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get install -y apt-transport-https     ca-certificates     curl     software-properties-common
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce


if [ -n "$USER" ] ; then
	DOCKERUSER="$USER"
else
	DOCKERUSER="$1"
fi

if ! sudo systemctl --no-pager status docker.service > /dev/null ; then
    sudo systemctl start docker.service
fi

if [ -n "$DOCKERUSER" ]; then
	sudo usermod -aG docker "$DOCKERUSER"
fi
