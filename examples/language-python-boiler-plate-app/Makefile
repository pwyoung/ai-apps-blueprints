# This is meant to be a re-usable/boiler-plate way to
# call a shell script within a Python virtual environment.

.PHONY:=default FORCE all clean clean-all build test

# Directory containing this makefile. Includes trailing /
MAKEFILE_PATH=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

# Name this project using the directory name
PWD:=$(shell pwd)
PROJECT:=$(shell basename "$(PWD)")

# Virtual environment: path
VENV_PARENT:=$(HOME)/virtual-environments
VENV:=$(VENV_PARENT)/$(PROJECT)

# Virtual environment: use
RUN:=. $(VENV)/bin/activate && $(MAKEFILE_PATH)/run

default: all

# Noop dependency. Reliable/idiomatic way to force the target to run.
FORCE:

clean-all: clean
	rm -rf $(HOME)/virtual-environments/$(PROJECT)

clean: FORCE
	$(RUN) --clean || true

format: FORCE
	@pip show black &>/dev/null || pip install black
	python3 -m black .

# Create the virtual environment if it does not exist
# This dependency is a directory. If it does not exist, this target (step) will be run.
$(VENV):
	[ -e "$(VENV)" ] || mkdir -p "$(VENV_PARENT)" && cd "$(VENV_PARENT)" && python3 -m venv $(PROJECT)

build: $(VENV) format
	$(RUN) --build

test: build
	$(RUN) --test

all: test
