#!/usr/bin/env bash

BASEDIR="$(dirname "$(readlink -f "$0")")"

versioncheck () {
	localversion="$(go version | awk '{ print $3 }')"
	remoteversion="$(curl "https://go.dev/dl/" 2> /dev/null | grep -oP '(?<=<a class="download downloadBox" href="/dl/).*(?=.linux-amd64.tar.gz">)')"
	if [ "$localversion" = "$remoteversion" ] ; then
		echo "Go is up to date"
		exit 0
	fi
}

versioncheck
TMPDIR="$(mktemp -d)"
URL="https://go.dev$(curl "https://go.dev/dl/" 2> /dev/null | grep -oP '(?<=<a class="download downloadBox" href=").*linux-amd64.tar.gz(?=">)')"

cd "$TMPDIR"
curl -L -o go.tgz "${URL}"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go.tgz
sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go

cd "$BASEDIR"
rm -rf "$TMPDIR"

go version
