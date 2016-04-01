#!/bin/bash

# Do not run this script directly. It will be copied into the Gulp builder
# container, and invoked by running the container. NPM installs cannot be 
# invoked during docker build, but instead can be executed on container startup,
# hence the need for this complicated script.

set -e

primed=/home/jab/.primed;

if [ ! -f primed ]; then
	# Configure container
	sh /usr/local/bin/configure.sh;

	# Configuration complete. Invoke the install.
	npm install .

	# A rebuild is required to make sure our sass dependencies are appropriate for
	# our Docker container's architecture.
	npm rebuild node-sass

	touch primed;
fi

exec "$@";