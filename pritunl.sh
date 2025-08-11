#!/bin/bash
sudo dnf install -y gnupg2
sudo rpm --import https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc

sudo tee /etc/yum.repos.d/pritunl.repo << EOF
[pritunl]
name=Pritunl Stable Repository
baseurl=https://repo.pritunl.com/stable/yum/fedora/40/
gpgcheck=1
enabled=1
gpgkey=https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc
EOF

sudo dnf update
sudo dnf install -y pritunl-client-electron
