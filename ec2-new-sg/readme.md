# Terraform AWS EC2 Instance with Provisioning

## Overview

This Terraform configuration launches an EC2 instance and automatically provisions it with essential tools and the AWS CLI v2 on first boot.

---

## Architecture

| Component          | Detail                                                  |
| :----------------- | :------------------------------------------------------ |
| **Provider**       | AWS (us-east-1)                                         |
| **Instance Type**  | t3.micro (2 vCPU, 1 GB RAM)                             |
| **AMI**            | `ami-091138d0f0d41ff90` (Ubuntu 22.04 LTS)              |
| **SSH Key**        | `nix-vm`                                                |
| **Security Group** | Custom `new-sg-terraform` (ports 22, 80, 8080, 82 open) |

---

## Files

| File              | Purpose                                             |
| :---------------- | :-------------------------------------------------- |
| `ec2-creation.tf` | EC2 instance resource with `user_data` provisioning |
| `new-sg.tf`       | Security group with ingress rules                   |

---

## What Gets Installed (user_data Script)

The `user_data` script runs **once** at instance launch and performs the following:

| Step | Command                                                     | Purpose                                       |
| :--- | :---------------------------------------------------------- | :-------------------------------------------- |
| 1    | `sudo apt update -y`                                        | Updates the package index                     |
| 2    | `sudo apt install tree zip unzip -y`                        | Installs `tree`, `zip`, and `unzip` utilities |
| 3    | `curl "https://awscli.amazonaws.com/..." -o "awscliv2.zip"` | Downloads AWS CLI v2 installer                |
| 4    | `unzip -o awscliv2.zip`                                     | Extracts the installer                        |
| 5    | `sudo ./aws/install --update`                               | Installs/updates AWS CLI v2                   |
| 6    | `rm -rf awscliv2.zip aws/`                                  | Cleans up installer files                     |
| 7    | `echo "✅ AWS CLI installed..."`                            | Logs confirmation with version                |

---

## Security Group Rules

| Port | Protocol | Source    | Purpose                 |
| :--- | :------- | :-------- | :---------------------- |
| 22   | TCP      | 0.0.0.0/0 | SSH access              |
| 80   | TCP      | 0.0.0.0/0 | HTTP                    |
| 8080 | TCP      | 0.0.0.0/0 | Alternative HTTP        |
| 82   | TCP      | 0.0.0.0/0 | Custom application port |

⚠️ **Warning:** Port 22 is open to the entire internet. Restrict `cidr_blocks` to your IP in production.

---

## Deployment

### 1. Initialize Terraform

```bash
terraform init
```
