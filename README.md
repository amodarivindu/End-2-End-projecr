# End to End DevOps Project

## Overview

This repository demonstrates a simple end-to-end DevOps workflow that combines infrastructure provisioning, application packaging, containerization, deployment, and automation.

The project includes:

- `terraform/` for AWS infrastructure provisioning
- `app/` for a small Flask application and Docker packaging
- `ansible/` for deploying the containerized app onto target hosts
- `Jenkinsfile` for an automated CI/CD pipeline

## Project Structure

- `Jenkinsfile` - defines the CI/CD pipeline used to build, push, provision, and deploy the application.
- `ansible/` - contains Ansible inventory and playbook to install Docker, pull the application image, and run it.
- `app/` - contains the Flask application source code and Docker build context.
- `terraform/` - contains Terraform code for creating AWS resources.
- `project/` - placeholder directory for additional project assets.

## Components

### 1. Application

The `app/` folder contains a simple Flask application in `app.py`.

- The app returns `"Hello from DevOps Project!"` at the root route `/`.
- It listens on `0.0.0.0:5000` when run.

### 2. Docker Build

The Jenkins pipeline builds a Docker image from the `app/` directory.

- Image tag used in the pipeline: `amodarivindu/myapp_new`
- The image is pushed to Docker Hub using configured credentials.

### 3. Terraform Infrastructure

The `terraform/` folder provisions AWS infrastructure, including:

- A VPC (`aws_vpc.main`)
- A subnet (`aws_subnet.main`)
- An Internet Gateway (`aws_internet_gateway.gw`)
- A route table and route for internet access
- Two EC2 instances (`aws_instance.app_server`) in the created subnet

The Terraform provider is AWS and the region is `us-east-1`.

### 4. Ansible Deployment

The `ansible/playbook.yml` deploys the application by:

- Installing Docker on target hosts
- Starting the Docker service
- Pulling the Docker image `amodarivindu/app:latest`
- Running the container on port `80` mapped to app port `5000`

The inventory is defined in `ansible/inventory.ini`.

## Jenkins Pipeline Flow

The `Jenkinsfile` contains the following stages:

1. `Build Docker Image`
   - Builds the Docker image using `docker build` in `./app`
2. `Push Image`
   - Logs into Docker Hub and pushes the built image
3. `Terraform Init`
   - Initializes the Terraform project in `terraform/`
4. `Terraform Apply`
   - Applies Terraform configuration to provision AWS infrastructure
5. `Deploy with Ansible`
   - Runs `ansible-playbook` against `ansible/playbook.yml`

## How to Use

1. Ensure required tools are installed:
   - Docker
   - Terraform
   - Ansible
   - Jenkins (if running the pipeline)
2. Configure AWS credentials for Terraform and Jenkins.
3. Run the pipeline or execute each stage manually.

## Notes

- The current Ansible playbook uses the image `amodarivindu/app:latest` in its deployment step.
- The Jenkins pipeline pushes `amodarivindu/myapp_new`, so ensure image naming is consistent if you want automated deployment to use the same image.
- This repository is a learning/demo project for end-to-end DevOps automation.
