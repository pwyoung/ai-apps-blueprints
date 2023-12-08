# This is meant to be a re-usable/boiler-plate way to
# call a shell script within a Python virtual environment.

.PHONY:=default FORCE all clean clean-all build test

# Directory containing this makefile. Includes trailing /
MAKEFILE_PATH=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

default: all

# Noop dependency. Reliable/idiomatic way to force the target to run.
FORCE:

clean-all: clean
	./run -C

clean: FORCE
	./run --clean

build: FORCE
	./run --build

test: build
	./run --test

all: test
