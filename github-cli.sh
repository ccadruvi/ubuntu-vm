#!/usr/bin/env bash
# Install GitHub CLI (gh)

echo "Installing GitHub CLI..."

# Add GitHub CLI repository manually
sudo curl -fsSL https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo

# Install GitHub CLI
sudo dnf install -y gh

echo "GitHub CLI installed successfully"
echo "Run 'gh auth login' to authenticate with GitHub"