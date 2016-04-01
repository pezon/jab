#!/bin/bash

set -eu

# symbolic link to script in local bins
chmod u+x,g+x ./bin/jab;
ln -s ./bin/jab /usr/local/bin/jab;
