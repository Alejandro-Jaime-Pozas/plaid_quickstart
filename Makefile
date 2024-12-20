# Makefile eases the deployment process
# use 'make up language=python' to run the python docker image
# or 'make stop' or 'make logs'
DOCKER_COMPOSE := docker compose
DOCKER_COMPOSE_YML := --file docker-compose.yml
ifneq ("$(wildcard docker-compose.local.yml)","")
DOCKER_COMPOSE_YML += --file docker-compose.local.yml
endif

# def language is node, can change in make command to python
language := node
SUCCESS_MESSAGE := "✅ $(language) quickstart is running on http://localhost:3000"

.PHONY: up
up:
	REACT_APP_API_HOST=http://$(language):8000 \
	$(DOCKER_COMPOSE) \
		$(DOCKER_COMPOSE_YML) \
		$@ --detach --remove-orphans \
		$(language)
	@echo $(SUCCESS_MESSAGE)

# dont know if this is overriding the stop build command below
.PHONY: build
build:
	REACT_APP_API_HOST=http://$(language):8000 \
	$(DOCKER_COMPOSE) \
		$(DOCKER_COMPOSE_YML) \
		up --$@ --detach --remove-orphans \
		$(language)
	@echo $(SUCCESS_MESSAGE)

.PHONY: logs
logs:
	$(DOCKER_COMPOSE) \
		$@ --follow \
		$(language) frontend

.PHONY: stop build
stop build:
	$(DOCKER_COMPOSE) \
		$(DOCKER_COMPOSE_YML) \
		$@ \
		$(language) frontend
