#!/bin/bash
set -euo pipefail

if ! command -v openvpn3 &> /dev/null; then
  sudo wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
  sudo apt-key add openvpn-repo-pkg-key.pub
  sudo wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-jammy.list
  sudo apt update
  sudo apt install openvpn3
fi

echo "Connect using 'openvpn3 session-start --config /home/christian/VPN-PlanetExpress_Christian.Cadruvi@digitecgalaxus.ch_PlanetExpress.ovpn'"
