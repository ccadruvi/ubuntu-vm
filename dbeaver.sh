#!/bin/bash
set -euo pipefail

if ! command -v dbeaver-ce &> /dev/null; then
        sudo apt update
        sudo apt -y install default-jdk
        curl -fsSL https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/dbeaver.gpg
        echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
        sudo apt update
        sudo apt install dbeaver-ce
fi

