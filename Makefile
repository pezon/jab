MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

include ./resources/docker.env

REMOTE_NAME := $(DOCKER_HOST)/$(DOCKER_ORG)/$(SERVICE_NAME)
RUN := docker-compose run $(IMAGE_NAME) --entrypoint

bootstrap:
	./bin/bootstrap.sh;

install: bootstrap
	./bin/install.sh;

build:
	docker build -t $(SERVICE_NAME) .

clean:
	for im in $$(docker images | grep '$(SERVICE_NAME)' | awk '{print $3}'); \
		do docker rmi --force $im; done;

pull:
	docker-compose pull;

push:
	docker tag $(SERVICE_NAME):$(IMAGE_TAG) $(REMOTE_NAME):$(IMAGE_TAG); \
	docker push $(IMAGE_NAME);

all: bootstrap build install

.PHONY: bootstrap install build clean pull push