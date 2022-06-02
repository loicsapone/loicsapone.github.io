# Executables (local)
DOCKER_COMP = docker-compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec php
NODE_CONT = $(DOCKER_COMP) exec node

# Executables
PHP = $(PHP_CONT) php
NODE = $(NODE_CONT) node

# Misc
.DEFAULT_GOAL = help
.PHONY        = help build up start down logs sh composer vendor sf cc

## —— Help 🐳 🎵 ———————————————————————————————————————————————————————————————
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull --no-cache

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --detach

start: build up ## Build and start the containers

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

php: ## Connect to the PHP FPM container
	@$(PHP_CONT) sh

node: ## Connect to the Node container
	@$(NODE_CONT) sh

## —— Project 🐝 ———————————————————————————————————————————————————————————————
install: ## Install project
	@$(NODE_CONT) yarn install

serve: ## Launch Cecil server
	@$(PHP_CONT) cecil serve --host=0.0.0.0 --port=8000 --clear-cache

watch: ## Launch assets compile
	@$(NODE_CONT) npx tailwindcss -i ./assets/css/app.css -o ./assets/dist/css/styles.css --watch