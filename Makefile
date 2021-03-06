include $(ENVFILE)
export

# Docker specific
COMPOSE_FILE := docker/docker-compose.yml
DOCKER := PYTHON_VERSION=$(PYTHON_VERSION) docker-compose -f $(COMPOSE_FILE) --env-file .env
DOCKER_UP := $(DOCKER) up
DOCKER_RUN := $(DOCKER) run --rm
DOCKER_BUILD := $(DOCKER) build
DOCKER_STOP := $(DOCKER) rm --force --stop
DOCKER_EXEC := $(DOCKER) exec
DOCKER_NETWORK_REMOVE := $(DOCKER) down --remove-orphans
DOCKER_IMAGES := $(docker images -q 'docker_dengue_db' | uniq)
DOCKER_REMOVE := docker rmi --force $(DOCKER_IMAGES) ###
SERVICES := nginx



build:
	$(DOCKER_BUILD)

deploy:
	$(DOCKER_UP) -d

exec: deploy
	$(DOCKER_EXEC) $(SERVICES) bash

remove_orphans:	
	$(DOCKER_NETWORK_REMOVE)

clean:
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name '*.pyo' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} \;
	rm -rf .cache
	rm -rf build
	rm -rf dist
	rm -rf *.egg-info