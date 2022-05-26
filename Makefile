#!/bin/bash

DOCKER_BE = gaming-shop-api

help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

run: ## Start the containers
	docker network create gaming-shop-network || true
	docker-compose up -d

stop: ## Stop the containers
	docker-compose stop

restart: ## Restart the containers
	$(MAKE) stop && $(MAKE) run

build: ## Rebuilds all the containers
	docker-compose build

# Backend commands
yarn-install: ## Installs dependencies
	docker exec -it ${DOCKER_BE} yarn install
# End backend commands

ssh-be: ## ssh's into the be container
	docker exec -it ${DOCKER_BE} bash
