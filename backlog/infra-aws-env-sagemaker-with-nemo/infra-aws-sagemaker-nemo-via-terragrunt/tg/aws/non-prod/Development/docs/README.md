# Build

Run "make" to create the environment.

For example:
```
cd .../aws/non-prod/Development/
make
```

# What this environment does

## This creates two VPCs, each with 3 subnets.

The VPC details (subnets, NAT gateways, etc) are specified
using default in the "vpc" directories.

As always, these can be overridden
```
# Create a variable override file
cd ~/git/ai-apps-blueprints/examples/infra-aws-sagemaker-with-nemo/tg/aws/non-prod/Development/us-east-2/vpc

emacs ./custom.auto.tfvars file.
```

## EC2 Instances

The us-east-2 VPC has two ec2 instances, one in a public subnet
and one in a private subnet.

You can use the first instance as an SSH jumpbox to the second.

```
# To get the IPs of the boxes, run
make get-ec2-ips
```


