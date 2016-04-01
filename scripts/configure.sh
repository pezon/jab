#!/bin/bash

# Do not run this script directly. It will be copied into the Gulp builder
# container, and invoked by running the container. NPM installs cannot be 
# invoked during docker build, but instead can be executed on container startup,
# hence the need for this complicated script.

set -eu

#
# Configure NPM
#

# These environment variables must be provided to our container.
if [ -z "$NPM_USERNAME" ]; then
    echo "You must set variables NPM_PASSWORD, NPM_EMAIL, and NPM_USERNAME."
    exit 1;
fi
if [ -z "$NPM_PASSWORD" ]; then
    echo "You must set variables NPM_PASSWORD, NPM_EMAIL, and NPM_USERNAME."
    exit 1;
fi
if [ -a "$NPM_EMAIL" ]; then
    echo "You must set variables NPM_PASSWORD, NPM_EMAIL, and NPM_USERNAME."
    exit 1;
fi

# Walk through the prompts for logging into our private npm registry.
npm set registry $NPM_HOSTNAME
npm set cafile $HOME/ca.crt
npm adduser --registry $NPM_HOSTNAME <<!
$NPM_USERNAME
$NPM_PASSWORD
$NPM_EMAIL
!

#
# Configure JSPM
#

# These environment variables must be provided to our container.
if [ -z "$GITHUB_USERNAME" ]; then
    echo "You must set variables GITHUB_USERNAME, GITHUB_TOKEN.";
    exit 1;
fi
if [ -z "$GITHUB_TOKEN" ]; then
    echo "You must set variables GITHUB_USERNAME, GITHUB_TOKEN.";
    exit 1;
fi

export GITHUB_AUTH=$(echo -ne "${GITHUB_USERNAME}:${GITHUB_TOKEN}" | base64);

jspm config registries.github.remote https://github.jspm.io;
jspm config registries.github.auth $GITHUB_AUTH;
jspm config registries.github.maxRepoSize 0;
jspm config registries.github.handler jspm-github;
