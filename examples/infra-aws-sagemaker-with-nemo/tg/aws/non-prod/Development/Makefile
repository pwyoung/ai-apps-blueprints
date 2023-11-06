# This facilitates development

.PHONY=default FORCE clean destroy apply build validate format graph

# default shell (for push/pop etc)
SHELL=/bin/bash

# Path to this Makefile
MAKEFILE_PATH=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

################################################################################
# KEY COMMANDS
################################################################################

# "terragrunt run-all plan --terragrunt-non-interactive" requires that
# dependencies have already been built.
#
# We can use "terragrunt run-all plan --terragrunt-non-interactive"
# to validate the entire system after it is built.
#
# "terragrunt run-all plan" will interactively ask you to call modules
# that are dependencies for the module againstg which the "plan" is run.
# That's good, but not needed here.
#
VALIDATE=terragrunt run-all plan --terragrunt-non-interactive

# Force terragrunt to build a module and all its dependencies.
#
# The non-interactive version of this will ignore (not run) dependent modules.
APPLY=yes y | terragrunt run-all apply

# Find all modules under this directory and destroy them
#
# This works under the current directory.
# It finds and destroys modules, respecting dependencies.
DESTROY=terragrunt run-all destroy --terragrunt-non-interactive 

################################################################################
# ADDITIONAL COMMANDS
################################################################################

# Make an image with the dependencies for the project
#
# This works under the current directory.
# It finds modules and builds the graph, respecting dependencies.
GRAPH=terragrunt graph-dependencies | dot -Tsvg > ~/tf-dependencies.svg

# Destroy the given module
DESTROY_MOD=terragrunt destroy -auto-approve

# This will fetch the latest module source.
# This is necessary if the module source or location has changed.
UPDATE=terragrunt run-all get -update

################################################################################
# The first target will be called if 'make' is run with no args.
# Name it 'default' for readability.
################################################################################

default: build

################################################################################
# Standard "make" targets (for convenience)
################################################################################

build: validate

clean: destroy

################################################################################
# This forces a target to run even if there is a file in the local dir with the
# name of the target. Also, this is good for readability
################################################################################

FORCE:

# Show how to use terragrunt on a per-directory basis
# This will do a bunch of useful house-keeping and is easy to debug so run it first.
# This will
#   - initialize the Terraform Backend
#   - run any AccountID validation checks
manual-example:
	cd ./global/main && terragrunt plan -out ./.tgplan && terragrunt apply ./.tgplan

#apply: FORCE
apply: manual-example
	cd ./global/main && $(APPLY)

validate: apply
	echo "Validating the last run by making sure the plan shows no changes are needed"
	cd ./global/main && $(VALIDATE)

# Destroy all modules found under this directory
destroy: FORCE
	$(DESTROY)
	echo "Check for orphaned resources like Elastic IPs"

################################################################################
# Manual/Optional conveniences
################################################################################

graph: validate
	$(GRAPH)

format: FORCE
	terraform fmt -recursive
	find ./ -name "*.hcl" 2>/dev/null | grep -v '.terra' | xargs terragrunt hclfmt

update: FORCE
	$(UPDATE)

# Destroy the modules, one at a time
destroy-mods: FORCE
	for i in `find ./ -name "terragrunt.hcl" | grep -v terragrunt-cache | sed 's|/terragrunt.hcl||' | sort -u | grep -v ./global/main`; do cd $(MAKEFILE_PATH)/$$i && pwd && $(DESTROY_MOD); done

# Some parameters, like EC2-Keypairs might not managed by this
# and so the parameters show "CHANGEME" to indicate they need to
# be created.
find-changeme-files:
	find ./ -name "*.hcl" | grep -v 'terragrunt-cache' | xargs grep CHANGEME

# Use this if re-purposing this code for a different project
# It might be possible to use
#   "terragrunt init -upgrade" on each dir instead.
purge-lock-and-cache-files:
	find ./ -name ".terragrunt-cache" | xargs rm -rf
	find ./ -name ".terraform.lock.hcl" | xargs rm
