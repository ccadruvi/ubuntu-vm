#!/bin/bash
set -euo pipefail

if ! command -v google-chrome &> /dev/null; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install ./google-chrome-stable_current_amd64.deb -y
  rm ./*.deb
fi
