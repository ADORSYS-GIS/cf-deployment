#!/bin/bash

# Script for deploying CloudFoundry on Ubuntu

# Install required dependencies
sudo apt-get update
sudo apt-get install -y build-essential git curl wget

# Install Docker if you don't have yet
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install CloudFoundry CLI
sudo apt-get install -y apt-transport-https
sudo wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
sudo apt-get update
sudo apt-get install -y cf-cli

# Install CloudFoundry BOSH CLI
sudo wget -q -O - https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-6.4.7-linux-amd64 > bosh
chmod +x bosh
sudo mv bosh /usr/local/bin

# Install CloudFoundry deployment tool (e.g., cf-deployment)
git clone https://github.com/cloudfoundry/cf-deployment.git
cd cf-deployment

# Deploy CloudFoundry
bosh create-env cf-deployment.yml --state=cf-state.json --vars-store=cf-vars.yml
