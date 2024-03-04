#!/usr/bin/env bash
set -e

versioncheck () {
	if [ -f "/etc/apt/sources.list.d/google-cloud-sdk.list" ] ; then
		echo "gcloud apt repo is already configured, unattended upgrades should take of updates."
		exit 0
	fi
}
versioncheck

sudo apt-get update
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb [signed-by=/usr/share/keyrings/google-keyring.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/google-keyring.gpg 

sudo apt-get update && sudo apt-get install -y google-cloud-sdk google-cloud-sdk-gke-gcloud-auth-plugin

# Manual step to configure gcloud
# gcloud init
# Manual step to configure kubectl
# gcloud container clusters get-credentials cluster -z europe-west1-b

# To make gsutil work, BOTO_CONFIG has to be set, see also https://stackoverflow.com/questions/38783140/importerror-no-module-named-google-compute-engine
export BOTO_CONFIG=/dev/null

gcloud auth configure-docker

gcloud init
