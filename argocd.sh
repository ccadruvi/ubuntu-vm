#!/usr/bin/env bash
set -euo pipefail

remoteversion="$(basename "$(curl -fsSLI -o /dev/null -w '%{url_effective}' https://github.com/argoproj/argo-cd/releases/latest)")"

if command -v argocd &> /dev/null; then
  localversion="$(argocd version --client --short | awk '{ print $2 }' | cut -d+ -f1)"
  if [ "$localversion" = "$remoteversion" ]; then
    echo "Argo CD CLI is up to date ($localversion)"
    exit 0
  fi
  echo "Updating Argo CD CLI $localversion -> $remoteversion"
else
  echo "Installing Argo CD CLI $remoteversion"
fi

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

curl -fsSL -o "$TMPDIR/argocd" "https://github.com/argoproj/argo-cd/releases/download/$remoteversion/argocd-linux-amd64"
sudo install -m 555 "$TMPDIR/argocd" /usr/local/bin/argocd

argocd version --client --short
