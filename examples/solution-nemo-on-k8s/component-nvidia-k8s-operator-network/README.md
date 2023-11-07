# Goal

Add Nvidia Network operator to a Vanilla K8S cluster.


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
https://catalog.ngc.nvidia.com/orgs/nvidia/teams/cloud-native/helm-charts/network-operator
specifically, for Vanillia K8S
https://docs.nvidia.com/networking/display/cokan10/network+operator#src-39285883_NetworkOperator-NetworkOperatorDeploymentonVanillaKubernetesCluster
