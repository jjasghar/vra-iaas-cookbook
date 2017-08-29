# This is the default action, it's always the first target
# .PHONY <target> at the end of the build step. Common phony targets
# are: clean, install, run,...
# Otherwise, if somebody creates an install directory, make will
# silently fail, because the build target already exists.

.PHONY: help kitchen kitchen_list

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# make target: <dependancies> ## comment for the self documenting
kitchen: ## Run test-kitchen test
	@bundle exec kitchen test

# make target: <dependancies> ## comment for the self documenting
kitchen_list: ## Run test-kitchen list
	@bundle exec kitchen list

# make target: <dependancies> ## comment for the self documenting
kitchen_dokken: ## export to kitchen-dokken
	@KITCHEN_YAML=.kitchen.dokken.yml bundle exec kitchen list

# make target: <dependancies> ## comment for the self documenting
kitchen_vcenter: ## export to kitchen-dokken
	@KITCHEN_YAML=.kitchen.vcenter.yml bundle exec kitchen list

# make target: <dependancies> ## comment for the self documenting
todos: ## grep out any TODOs you might have forgotten
	@if grep -r --exclude=Makefile TODO * ; then echo "Looks like you got some TODOs left" ; else echo "Good to go, or maybe release..." ; fi

# make target: <dependancies> ## comment for the self documenting
update_chefdk: ## Update the ChefDK because you need to sometimes
	@curl -L https://chef.io/chef/install.sh | sudo bash -s -- -P chefdk

# If you want to have it at the bottom of the file:
# .DEFAULT_GOAL := help
