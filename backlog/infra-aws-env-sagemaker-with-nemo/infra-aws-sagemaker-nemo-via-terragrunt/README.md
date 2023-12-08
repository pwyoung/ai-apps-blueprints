# GOAL

Create an AWS environment for running Nvidia Nemo
that utilitizes Nvidia GPU acceleration.

# Background

Sagemaker is an AWS Managed service for Jupyter Notebooks.
It adds "SageMaker Domains" which support:
- users
- shared file system (EFS)

# Gotchas

The downsides include:
- Resources (e.g. EC2 instances) are not visible easily
- I have had cost tracking issues where my account was
  incurred 100s of dollars in charges for merely creating
  and destroying Domains and EFS systems repeatedly.
  There is some "backend" stuff happening which is not visible
  and only appears as a single line item in cost tracking.


# Status

Due to the above, and immediate other needs, focus has changed to
K8S using IAAS.
