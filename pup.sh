#!/usr/bin/env bash
set -euo pipefail

remotetag="$(basename "$(curl -fsSLI -o /dev/null -w '%{url_effective}' https://github.com/DataDog/pup/releases/latest)")"
remoteversion="${remotetag#v}"

if command -v pup &> /dev/null; then
  localversion="$(pup --version | awk '{ print $2 }')"
  if [ "$localversion" = "$remoteversion" ]; then
    echo "Pup is up to date ($localversion)"
    exit 0
  fi
  echo "Updating Pup $localversion -> $remoteversion"
else
  echo "Installing Pup $remoteversion"
fi

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

base="https://github.com/DataDog/pup/releases/download/$remotetag"
tarball="pup_${remoteversion}_Linux_x86_64.tar.gz"
curl -fsSL -o "$TMPDIR/$tarball" "$base/$tarball"
curl -fsSL -o "$TMPDIR/checksums.txt" "$base/pup_${remoteversion}_checksums.txt"
(cd "$TMPDIR" && grep " $tarball\$" checksums.txt | sha256sum -c -)

tar -xzf "$TMPDIR/$tarball" -C "$TMPDIR" pup
sudo install -m 555 "$TMPDIR/pup" /usr/local/bin/pup

pup --version
