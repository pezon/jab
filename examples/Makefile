MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

include ./resources/docker.env

REMOTE_NAME := $(DOCKER_HOST)/$(DOCKER_ORG)/$(SERVICE_NAME)
RUN := docker-compose run -it $(IMAGE_NAME) --entrypoint

# Jab commands
# 
# (i.e., mappings to gulpfile npm commands)

init:
	docker-machine start $(MACHINE_NAME);
	docker-compose up -d;

install: init
	$(RUN) npm install

test: init
	$(RUN) karma start

watch: init
	$(RUN) karma start --no-single-run --auto-watch

build: init
	$(RUN) gulp build;

run: init
	$(RUN) gulp

dist: init
	$(RUN) jspm bundle-sfx js/app dist/app.min.js --minify --skip-source-maps

# Docker
#

status:
	docker-compose ps;

logs:
	docker-compose logs $(IMAGE_NAME);

# Entrypoints
#

cli: 
    $(RUN) bash;

gulp:
    $(RUN) gulp;

jspm:
    $(RUN) jspm;

karma:
    $(RUN) karma;

npm:
    $(RUN) npm;