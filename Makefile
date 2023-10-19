# Directories
TERRAFORM_DIR = $(abspath terraform/)

# CLI
TERRAFORM_CLI ?= $(shell which terraform)

# ******************************************************************
##@ Helpers

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[3mcommand\033[0m \n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: init
init: ## Init projects
	cd $(TERRAFORM_DIR) && $(TERRAFORM_CLI) init

.PHONY: plan
plan: ## Plan the terraform project
	cd $(TERRAFORM_DIR) && $(TERRAFORM_CLI) plan

.PHONY: apply
apply: ## Apply the terraform project
	cd $(TERRAFORM_DIR) && $(TERRAFORM_CLI) apply

.PHONY: destroy
destroy: ## Destroy the terraform project
	cd $(TERRAFORM_DIR) && $(TERRAFORM_CLI) destroy