#!/usr/bin/env bash
# Install docker


versioncheck () {
        APT_SOURCE_LINE="$(grep "^deb.*docker" /etc/apt/sources.list || true)"
        if [ -z "$APT_SOURCE_LINE" ] ; then
                echo "docker apt repo is already configured, unattended upgrades should take of updates."
                exit 0
        fi
}

versioncheck

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get install -y apt-transport-https     ca-certificates     curl     software-properties-common
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update
sudo apt-get install -y docker-ce

if [ -n "$USER" ] ; then
    DOCKERUSER="$USER"
else
        DOCKERUSER="$1"
fi

if ! sudo systemctl --no-pager status docker.service > /dev/null ; then
    sudo systemctl start docker.service
fi

if [ -n "$DOCKERUSER" ]; then
    if ! id "$DOCKERUSER" ; then
        adduser "$DOCKERUSER"
    fi
    sudo usermod -aG docker "$DOCKERUSER"
fi
