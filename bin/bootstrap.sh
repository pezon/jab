#!/bin/bash

set -eu

source resources/docker.env;

DOCKER_HOME=$HOME/.docker;

# create docker-machine, if doesn't exist
if ! docker-machine ls | grep "^${MACHINE_NAME} "; then 
	docker-machine create -d virtualbox -virtualbox-disk-size 80000 $MACHINE_NAME;

	# setup docker-machine environment on startup
	echo "eval $(docker-machine env ${MACHINE_NAME})" >> $HOME/.bash_profile;
fi;

# setup docker-machine environment
eval $(docker-machine env $MACHINE_NAME);

# login to docker registry, if not already
if [ ! -f $DOCKER_HOME/config ] || ! grep "${DOCKER_HOME}/config"; then
	docker login $DOCKER_HOST;
fi;