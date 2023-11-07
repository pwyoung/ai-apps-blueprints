# Goal

Add Nvidia GPU operator to a K8S cluster.

# Details

The K8S GPU Operator is the mechanism Nvidia recommends to enable access
to their GPUs on K8S clusters.

The operator will automatically detect nodes with Nvidia GPUs and configure them
to run Nvidia's container runtime which provides access to the GPU.

The operator works by running two processes.
First, nodes with GPUs are labeled to recognize that they contain an Nvidia GPU.
The second process labels a subset of the first nodes to indicate whether they
should be configured to use the Nvidia container runtime.
This allows an admin to label nodes in order to tell the operator to not configure
the runtime on them.

# Requirements

## Host running this code
- Bash
- Make

## Target machines
- Platform
  Any CNCF K8S cluster

# Tested configuratios

K8S cluster managed by Kubespray running on ubuntu-v22.04.2

# Running the code

To build and test, just run
```make```

To just run one task at a time, such as testing the system,
you can call the "run" script directly, e.g.:
```./run -t```

# Docs
This implements the steps at
https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/index.html
https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html#install-nvidia-gpu-operator

