#!/bin/bash
set -euo pipefail

if ! command -v google-chrome &> /dev/null; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
  sudo dnf install ./google-chrome-stable_current_x86_64.rpm -y
  rm ./*.rpm
fi
