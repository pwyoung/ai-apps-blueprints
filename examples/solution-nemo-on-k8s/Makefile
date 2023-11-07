# This is meant to be a re-usable/boiler-plate way to
# call a shell script within a Python virtual environment.

.PHONY:=default FORCE proxmox-kubespray

RUN=./run

default: proxmox-kubespray

# Noop dependency. Reliable/idiomatic way to force the target to run.
FORCE:

proxmox-kubespray:
	$(RUN) -p

clean-proxmox-kubespray:
	$(RUN) -P

