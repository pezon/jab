#!/bin/bash

# Do not run this script directly. It will be copied into the Gulp builder
# container, and invoked by running the container. NPM installs cannot be 
# invoked during docker build, but instead can be executed on container startup,
# hence the need for this complicated script.

set -eu

# Update and remove unnecessary packages.
apt-get -y update --fix-missing;
apt-get -y autoremove;

# Install git and ruby.
apt-get -y install git ruby vim;

# Install Gulp and JSPM globally.
npm install -g jspm;
npm install -g gulp;

# Install SASS
gem install sass;

# Create jab user
useradd --create-home --skel=/etc/skel --shell=/bin/bash jab;
chown -R builder /home/jab/;
su - jab;
