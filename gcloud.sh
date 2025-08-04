#!/usr/bin/env bash
set -e

versioncheck () {
	if [ -f "/etc/yum.repos.d/google-cloud-sdk.repo" ] ; then
		echo "gcloud dnf repo is already configured, dnf should take care of updates."
		exit 0
	fi
}
versioncheck

# Install Google Cloud CLI via official installation script
echo "Installing Google Cloud CLI via official script..."
curl https://sdk.cloud.google.com | bash
echo "Please restart your shell or run: source ~/.bashrc"
echo "Then run: gcloud init"

# Alternative method if script fails:
# sudo dnf install -y python3 python3-pip
# pip3 install --user google-cloud-cli

# Manual step to configure gcloud
# gcloud init
# Manual step to configure kubectl
# gcloud container clusters get-credentials cluster -z europe-west1-b

# To make gsutil work, BOTO_CONFIG has to be set, see also https://stackoverflow.com/questions/38783140/importerror-no-module-named-google-compute-engine
export BOTO_CONFIG=/dev/null

gcloud auth configure-docker

gcloud init
