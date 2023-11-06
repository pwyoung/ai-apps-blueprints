.PHONY=default apply plan format FORCE

default: non-prod-dev

non-prod-dev: FORCE
	cd ./aws/non-prod/Development && make

# Use this if re-purposing this code for a different project
# It might be possible to use
#   "terragrunt init -upgrade" on each dir instead.
purge-lock-and-cache-files:
	find ./ -name ".terragrunt-cache" | xargs rm -rf
	find ./ -name ".terraform.lock.hcl" | xargs rm
	echo "Removed"

FORCE:
