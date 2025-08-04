#!/bin/bash
set -euo pipefail

if ! command -v dbeaver-ce &> /dev/null; then
        # Install Java (required for DBeaver)
        sudo dnf install -y java-latest-openjdk
        
        # Download and install DBeaver RPM directly
        echo "Downloading DBeaver Community Edition..."
        curl -fsSL -o dbeaver-ce.rpm "https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm"
        sudo dnf install -y ./dbeaver-ce.rpm
        rm dbeaver-ce.rpm
        
        echo "DBeaver CE installed successfully"
fi

