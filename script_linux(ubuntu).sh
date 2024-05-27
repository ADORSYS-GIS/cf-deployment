#!/bin/bash

# Error handling function
handle_error() {
    echo "Error occurred in script at line: $1" >&2
    exit 1
}
trap 'handle_error $LINENO' ERR

# Logging function
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

log "Starting CloudFoundry deployment script..."

# Update and install dependencies
log "Updating package index and installing dependencies..."
sudo apt-get update
sudo apt-get install -y build-essential git curl wget

# Install Docker if not already installed
if ! command -v docker &> /dev/null; then
    log "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Install CloudFoundry CLI
if ! command -v cf &> /dev/null; then
    log "Installing CloudFoundry CLI..."
    sudo apt-get install -y apt-transport-https
    sudo wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
    echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
    sudo apt-get update
    sudo apt-get install -y cf-cli
fi

# Install CloudFoundry BOSH CLI
if ! command -v bosh &> /dev/null; then
    log "Installing CloudFoundry BOSH CLI..."
    sudo wget -q -O - https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-6.4.7-linux-amd64 > bosh
    chmod +x bosh
    sudo mv bosh /usr/local/bin
fi

# Clone CloudFoundry deployment tool repository if not already cloned
if [ ! -d "cf-deployment" ]; then
    log "Cloning CloudFoundry deployment tool repository..."
    git clone https://github.com/cloudfoundry/cf-deployment.git
fi

# Deploy CloudFoundry
log "Deploying CloudFoundry..."
cd cf-deployment
bosh create-env cf-deployment.yml --state=cf-state.json --vars-store=cf-vars.yml

log "CloudFoundry deployment completed successfully."
