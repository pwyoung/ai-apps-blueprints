# This facilitates development

.PHONY=default FORCE build validate clean format graph update
.PHONY+= get-public-ec2-instance-ip show-all-outputs
.PHONY+= destroy-mods find-changeme-files purge-lock-and-cache-files

# default shell (for push/pop etc)
SHELL=/bin/bash

# Path to this Makefile
MAKEFILE_PATH=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

CFG_FILES=./us-east-2/prv/ec2/custom.auto.tfvars ./us-east-2/pub/ec2/custom.auto.tfvars

################################################################################
# KEY COMMANDS
################################################################################

# Without "-upgrade", this will set the provider version in
# the .terraform.lock.hcl file(s)
INIT=terragrunt init

# Force terragrunt to build a module and all its dependencies.
#
# The non-interactive version of this will ignore (not run) dependent modules.
BUILD=yes y | terragrunt run-all apply 

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

# Find all modules under this directory and destroy them
#
# This works under the current directory.
# It finds and destroys modules, respecting dependencies.
DESTROY=terragrunt run-all destroy --terragrunt-non-interactive 

################################################################################
# Standard "make" targets (for convenience)
################################################################################

# The first target will be called if 'make' is run with no args.
# Name it 'default' for readability.
default: validate

# This forces a target to run even if there is a file in the local dir with the
# name of the target. Also, this is good for readability
FORCE:

init: FORCE
	cd ./global/main && $(INIT)

# Build the whole environment
build: init $(CFG_FILES)
	cd ./global/main && $(BUILD)

validate: build
	echo "Validating the last run by making sure the plan shows no changes are needed"
	cd ./global/main && $(VALIDATE)

clean: FORCE
	$(DESTROY)
	echo "Check for orphaned resources like Elastic IPs"

format: FORCE
	terraform fmt -recursive
	find ./ -name "*.hcl" 2>/dev/null | grep -v '.terra' | xargs terragrunt hclfmt

# Fail if a config file does not exist
$(CFG_FILES):
	$(error Create $@ )

################################################################################
# Manual/Optional conveniences
################################################################################

# Make an image with the dependencies for the project
#
# This works under the current directory.
# It finds modules and builds the graph, respecting dependencies.
graph: validate
	terragrunt graph-dependencies | dot -Tsvg > ~/tf-dependencies.svg

# This will fetch the latest module source.
# This is necessary if the module source or location has changed.
update: FORCE
	terragrunt run-all get -update

# Show how to get an output value from a component
get-ec2-ips: FORCE
	echo "Getting IPs for the public and private subnets in us-east-2"
	cd $(MAKEFILE_PATH)/us-east-2/pub/ec2 && terragrunt output -json | jq -r .public_ips.value[]
	cd $(MAKEFILE_PATH)/us-east-2/prv/ec2 && terragrunt output -json | jq -r .private_ips.value[]

# Dump all output values
show-all-outputs: FORCE
	terragrunt run-all output -json

# Destroy the modules, one at a time
destroy-mods: FORCE
	for i in `find ./ -name "terragrunt.hcl" | grep -v terragrunt-cache | sed 's|/terragrunt.hcl||' | sort -u | grep -v ./global/main`; do cd $(MAKEFILE_PATH)/$$i && pwd && yes | echo 'y' | terragrunt destroy -auto-approve; done

# Find the files with "CHANGEME" in them.
# For these files, a <FOO>.auto.tfvars file should be created to
# set the variable to a valid value.
find-changeme-files: FORCE
	find ./ -name "*.hcl" | grep -v 'terragrunt-cache' | xargs grep CHANGEME

# Use this if re-purposing this code for a different project
# It might be possible to use
#   "terragrunt init -upgrade" on each dir instead.
purge-lock-and-cache-files: FORCE
	find ./ -name ".terragrunt-cache" | xargs rm -rf
	find ./ -name ".terraform.lock.hcl" | xargs rm


