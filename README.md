# jab
Javascript Application Builder

It's a docker container with binaries to build and serve a javascript application.

jab includes:

* node
* npm
* jspm
* gulp
* karma
* Ruby SASS

## Requirements

You need the following installed:

* Docker Engine
* Docker Toolbox (aka Docker Machine)
* Docker Compose

## Usage

jab can used one of two ways.

1. Install as an executable
2. Include in your docker-compose projects

## Docker compose

Create and setup docker-machine environment. (Skip if you've already done this.)

	make bootstrap

Create docker-compose.yml

	hyperdrive:
	    image: "quay.io/decipher/jab:latest"
	    env_file: 
	        - ./resources/jab.env
	    user: jab
	    tty: true
	    volumes:
	        - ".:/code"

Create `resources/jab.env` in project directory.

Start service with docker-compose

	docker-compose up -d;

Run commands against service with docker-compose

	docker-compose run -it hyperdrive --entrypoint npm install;
	docker-compose run -it hyperdrive --entrypoint npm build;

You can alias `docker-command run -it <service> --entrypoint` as a bash alias, or you can create a `Makefile`. See `examples/Makefile` for an example.

## Jab executable

### Install

Create and setup docker-machine environment. (Skip if you've already done this.)

	make bootstrap

Build docker image. (Skip if you want to use a repository image.)

	make build

Create a symbolic link for jab in `/usr/local/bin`.

	make install

To run all three steps in one fell swoop.

	make

Login to repository.

	make login

If you want to use a repository image.

	make pull

If you want to push changes to repository.

	make push

### Usage

When inside a javascript app directory with package.json at the root, just execute...

	jab

or get fancy.

	jab npm install
	jab npm build
	jab npm run
	jab gulp

See `examples/Makefile` for more examples.

# Notes

Project directory must include:

	+
	|__ package.json
	|__ src/
