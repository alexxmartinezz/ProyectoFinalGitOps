# GitOps Final Practice

This project implements an automated Infrastructure as Code (IaC) pipeline using Terraform and Ansible, orchestrated by GitHub Actions.

## Project Overview

The goal is to provision AWS infrastructure and configure it automatically.
- **Terraform**: Provisions the infrastructure (EC2, RDS, etc.).
- **Ansible**: Configures the provisioned instances (Webserver role).
- **GitHub Actions**: Automates the validation, deployment, and destruction processes.

## Workflows

The project includes three main GitHub Actions workflows located in `.github/workflows/`:

### 1. CI - Validation (`ci.yml`)
**Purpose**: Validates the code quality and syntax before deployment.
- **Trigger**: Manual (`workflow_dispatch`).
- **Steps**:
  - **Terraform**: Runs `fmt`, `init`, and `validate` to ensure Terraform code is correctly formatted and valid.
  - **Ansible**: Runs `ansible-lint` to check playbooks for best practices and errors.

### 2. CI/CD (`main.yml`)
**Purpose**: Deploys the infrastructure and applies configurations.
- **Trigger**: Automatically runs after "CI - Validation" completes successfully, or can be triggered manually (`workflow_dispatch`).
- **Jobs**:
  - **Terraform**:
    - Initializes Terraform.
    - Plans the changes.
    - Applies the changes (`auto-approve`).
  - **Ansible** (runs after Terraform):
    - Installs Ansible and AWS dependencies (`boto3`).
    - Sets up the SSH private key from secrets.
    - Runs the `site.yml` playbook using the dynamic inventory.

### 3. Terraform Destroy Only (`shutdown.yml`)
**Purpose**: Tears down the infrastructure to avoid unnecessary costs.
- **Trigger**: Manual (`workflow_dispatch`).
- **Steps**:
  - Waits for 3 minutes (safety buffer).
  - Runs `terraform destroy` to remove all provisioned resources.

## Ansible Configuration

- **Inventory**: Uses `aws_ec2.yml` dynamic inventory plugin to discover EC2 instances.
  - Filters instances by tag `Owner: "Alejandro Martinez"` and state `running`.
  - Uses the public IP address for connection.
- **Playbook**: `site.yml` applies the `webserver` role to all discovered hosts.
