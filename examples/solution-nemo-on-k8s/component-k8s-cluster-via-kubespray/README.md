# Goal

Create a production-ready K8S cluster

# Details

Kubespray is a CNCF certified K8S installer.
It supports deployment to bare-metal and IAAS machines
running a major Linux distribution.

This creates a Python virtual environment so that all dependencies
can be managed independent of the system Python.

Ansible itself is installed in the Python virtual environment.
This is useful/necessary since Kubespray requires ansible-core
to be in a certain range of versions.

Kubespray will configure the first two IPs in the cluster as
control nodes; i.e. with kubectl, kube config, etc.

This will build a cluster and test it by fetching the kube
config remotely and putting it in ~/.kube/config.kubespray_$CN
where $CN identifies the (ansible/SSH) user and IP of the first node in the cluster.

# Requirements

## Host running this code
- Bash
- Make
- Python3

## Target machines
- Platform
  A set of existing Linux machines (bare-metal or virtual)
- OS
  All major versions of Linux are supported
- SSH/Admin Access
  The SSH target machines should be accessible via passwordless-SSH.
  The SSH/Ansible user should be root or has passwordless SUDO.
- Docs
  This code follows https://github.com/kubernetes-sigs/kubespray#quick-start

# Tested configuratios

This was tested with target machines running ubuntu-v22.04.2

# Configuration/Setup

Options:
- Option #1:
  Create/Edit ./tf/config/hosts.yaml
  This will be used then the code runs
- Option #2:
  Remove ./tf/config/hosts.yaml
  Edit ./tf/config/ips.txt
  This will be used to create ./tf/config/hosts.yaml

# Running the code

To build and test, run
```make```

To just run one task at a time, such as testing the system,
you can call the "run" script directly, e.g.:
```./run -t```
