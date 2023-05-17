#!/usr/bin/env bash
set -euo pipefail

if  ! command -v firefox &> /dev/null; then
        sudo snap remove firefox
        sudo add-apt-repository ppa:mozillateam/ppa
        echo '
        Package: *
        Pin: release o=LP-PPA-mozillateam
        Pin-Priority: 1001
        ' | sudo tee /etc/apt/preferences.d/mozilla-firefox
        echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
        sudo apt update
        sudo apt install firefox
fi
