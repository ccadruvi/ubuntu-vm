#!/usr/bin/env bash
# Install Docker CE

echo "Installing Docker CE..."

# Remove old Docker packages if they exist
sudo dnf remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# Install dnf-plugins-core
sudo dnf install -y dnf-plugins-core

# Add Docker repository manually (since config-manager --add-repo doesn't work)
sudo curl -fsSL https://download.docker.com/linux/fedora/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo

# Install Docker CE
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable --now docker

if [ -n "$USER" ] ; then
    DOCKERUSER="$USER"
else
    DOCKERUSER="$1"
fi

# Add user to docker group
if [ -n "$DOCKERUSER" ]; then
    if id "$DOCKERUSER" &>/dev/null; then
        sudo usermod -aG docker "$DOCKERUSER"
        echo "Added $DOCKERUSER to docker group"
        echo "Please log out and back in for group changes to take effect"
    fi
fi

echo "Docker CE installed and service started"

