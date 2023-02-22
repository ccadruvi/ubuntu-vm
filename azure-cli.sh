#!/bin/bash

versioncheck () {
        if [ -f "/etc/apt/sources.list.d/azure-cli.list" ] ; then
                echo "azure cli is already installed"
                exit 0
        fi
}

versioncheck

sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
# azure cli doesn't support non-lts releases of Ubuntu
#AZ_REPO=$(lsb_release -cs)
AZ_REPO=jammy
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update
sudo apt-get install azure-cli
