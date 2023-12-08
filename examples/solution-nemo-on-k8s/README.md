# Goal

Create a solution that can run a GenAI "RAG" use-case on a system
that is (or mimics) an on-prem deployment.

This will demonstrate:
- Deployment of Nvidia Nemo to an on-prem platform
- Running Inference using Nvidia Triton Inference Server
- How to incorporate custom data files into an LLM system

# Requirements

- Implement the NVIDIA example system here, but for K8S, in a modular way
  - https://docs.nvidia.com/ai-enterprise/workflows-generative-ai/0.1.0/technical-brief.html

# Details

- The system must run on-prem as it would in any cloud environment.
    - The system should use bare-metal or IaaS deployed using IaC tools (Terraform/Terragrunt)
- The system must be modular.
    - Each component should be built using code in a dedicated directory
    - Each component should be built with the intention that alternatives might
      be selected.
    - Components should represent major blocks in the architecture diagram
      and standalone projecs in directories that can be run with
      simple config and running a single command (e.g. "make")
- The code should be reliable and share-able
  - Code should be idempotent and include tests
  - Expect that we might re-use components in
    other projects.

# Current Solution Components/Steps

- Create a K8S cluster
 - Option A: Use Kubespray to Linux hosts
   - Create a set of Linux machines (and note their IPs):
     - Options:
       - component-aws-vms-via-terragrunt # <TODO: export IPs>
       - component-proxmox-vms-via-terraform
       - component-azure-vms-via-terragrunt # <TODO: create>
   - Install K8S via Ansible (given a list of IPS)
     - component-k8s-cluster-via-kubespray
- Configure the K8S cluster with dependencies for Nvidia Nemo
  - Deploy Nvidia Operators
    - component-nvidia-k8s-operator-gpu
    - component-nvidia-k8s-operator-mpi
    - component-nvidia-k8s-operator-network
    - component-nvidia-k8s-operator-training
- Configure the cluster for Nemo
  - component-nfs-server
  - component-nvidia-nemo-on-k8s

TODO
- component Vector Database
  - Milvus: https://milvus.io/
- component NVIDIA TensorRT-LLM
  https://nvidia.github.io/TensorRT-LLM/
  https://github.com/NVIDIA/TensorRT-LLM/tree/main
- component NVIDIA Triton Inference Server
  https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tritonserver
- component Jupyter Notebook
- <TODO: add the code to import data and run the RAG job>
