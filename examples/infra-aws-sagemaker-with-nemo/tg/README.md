# Goal
This will:
- create two VPCs
- peer them
- add public and private EC2 instances
- add a Network-Load-Balancer to one VPC and attach the public instances in that VPC to it

# Scope

This project is laid out on disk so that we can easily support multiple:
- Clouds (AWS is the current example)
- Deployment types (prod, non-prod, etc)
  ***This is important***
  There are checks to make sure that differnt AWS Accounts are used for prod vs non-prod.
- Environments (Development, QA, Staging, Test)

# Disk Structure
This project is laid out on disk so that we can easily see the
"physical" structure reflected in the deployment.
For example, under aws/non-prod/Development the folders are

├── Makefile
├── env.hcl
├── global
│   ├── iam
│   │   ├── private_ec2_instance_profile
│   │   │   └── terragrunt.hcl
│   │   └── public_ec2_instance_profile
│   │       └── terragrunt.hcl
│   ├── main
│   │   └── terragrunt.hcl
│   ├── region.hcl
│   └── vpc-peering
│       └── us-east-1_us-east-2
│           └── terragrunt.hcl
├── us-east-1
│   ├── prv
│   │   ├── ami
│   │   │   └── terragrunt.hcl
│   │   ├── ec2
│   │   │   └── terragrunt.hcl
│   │   ├── scope.hcl
│   │   └── sg
│   │       └── terragrunt.hcl
│   ├── pub
│   │   ├── ami
│   │   │   └── terragrunt.hcl
│   │   ├── ec2
│   │   │   └── terragrunt.hcl
│   │   ├── nlb
│   │   │   └── terragrunt.hcl
│   │   ├── nlb_attach_public_ec2_instances
│   │   │   └── terragrunt.hcl
│   │   ├── scope.hcl
│   │   └── sg
│   │       └── terragrunt.hcl
│   ├── region.hcl
│   └── vpc
│       └── terragrunt.hcl
└── us-east-2
    ├── region.hcl
    └── vpc
        └── terragrunt.hcl

# Advantages

Wherever you see a terragrunt.hcl file, you can work on just that component.
Unlike Terraform, you do not need to process the whole resource tree every time.
You can just run:



# SETUP

This assumes you are working in the default
environment, "./aws/non-prod/Development"

## Edit the config  as needed.

Find the files that must be edited with
find ./ -name "auto-tfvars-EXAMPLE"

For each of these, make a new file that will be
actually used, and update its contents.
```
cp ./auto-tfvars-EXAMPLE ./auto.tfvars
edit ./auto.tfvars
```

## Build the environment

```
# Build the environment by going to its directory
cd ./tg/aws/non-prod/Development
make
```

```
# There is convenience Makefile that will run assume
# you want to build in the "non-prod" Development environment
cd ./tg
make
```




