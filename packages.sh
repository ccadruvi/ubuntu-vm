#!/usr/bin/env bash
set -e

INSTALL="sudo dnf install -y"
BASEDIR="$(dirname "$(readlink -f "$0")")"
PACKAGELIST="$BASEDIR/files/package.list"

sudo dnf update -y
$INSTALL $(grep -v "^#" "$PACKAGELIST" | sed -e "s/\(.*\)#.*/\1/g" | tr "\\n" " ")

