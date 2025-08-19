#!/usr/bin/env bash
set -e

# Ansible installation script based on Dockerfile dependencies
# From: git/Dg.ContainerDevelopment/Images/Ansible/.devcontainer/Dockerfile

INSTALL="sudo dnf install -y"

echo "Installing Ansible and dependencies..."

# Update system first
sudo dnf update -y

# Install base development packages
$INSTALL openssl-devel libffi-devel python3-devel python3-pip sshpass

# Install Python packages via pip
pip3 install --user netaddr ansible ansible-lint jmespath datadog

# Install Ansible Galaxy collections
ansible-galaxy collection install community.general

echo "Ansible installation completed!"
echo "Installed packages:"
echo "  - ansible (via pip3)"
echo "  - ansible-lint (via pip3)" 
echo "  - netaddr (via pip3)"
echo "  - jmespath (via pip3)"
echo "  - datadog (via pip3)"
echo "  - community.general collection"
echo ""
