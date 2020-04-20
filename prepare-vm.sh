#!/usr/bin/env bash
set -ex -o pipefail

BASEDIR="$(dirname "$(readlink -f "$0")")"

bash "$BASEDIR/packages.sh"
#bash "$BASEDIR/gcloud.sh"
bash "$BASEDIR/golang.sh"
bash "$BASEDIR/docker.sh" $(whoami)
