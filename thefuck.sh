#!/bin/bash

if ! command -v fuck &>/dev/null; then
  sudo snap install --beta thefuck --classic
fi
