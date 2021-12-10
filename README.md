# Learning Terraform with an AWS Remote State

This repository contains a complete working example for using Terraform to setup and teardown cloud infrastructure in AWS, while also using AWS for it's remote state management, which is useful when working as part of a team (i.e. it stores the state in the cloud instead of on the local device).

> This has been setup on a Linux OS, so the scripts will only run when a shell is accessible.

## Prerequisites

1. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
1. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
1. [AWS Vault](https://github.com/99designs/aws-vault) _recommended_
1. [GNU Make](https://www.gnu.org/software/make/)

> GNU Make may already be present on your machine. Run `make --version` to check if it is.

## Quick Start

To quickly get setup and deploy the infrastructure into your AWS account, follow the below steps.

> It is recommended that you use [AWS Vault](https://github.com/99designs/aws-vault) to manage your AWS credentials. Doing so will allow you to run the below commands within a [subshell](https://tldp.org/LDP/abs/html/subshells.html). Alternately, you will need to ensure you have run `aws configure` with your AWS Access Id and Secret Key.

```shell
# Initialize the backend and remote state
$ make init

# Deploy all layers of the infrastructure within AWS
$ make infra
```

When you want to tear it all back down again (which I recommend you do, so that you do not incur costs), run these commands:

```shell
# If you only want to tear down the infrastructure, but keep the remote state intact
$ make destroy

# If you want to completely reset your AWS setup and remove the Terraform state as well
$ make destroy-state
```

Each time a layer is applied or destroyed, it will require approval after calculating the plan. If you want to skip approval and just go for it, you can set the environment variable `AUTO_APPROVE` to `true`. For example:

```shell
$ AUTO_APPROVE=true make infra
```

> You can also completely remove everything (including local state and lock files) using `make destroy-everything`.
