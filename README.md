# Yii2 Docker Swarm Deployment

## Overview

This project deploys a Yii2 PHP application as a Docker service on an AWS EC2 instance using Docker Swarm. CI/CD is automated via GitHub Actions with image build, push, deployment, and rollback on failure.

---

## Setup Instructions

### Prerequisites

- AWS EC2 instance(s) with Docker and Docker Swarm initialized. (Created the Ansible script for the same)
- Docker Hub account or GitHub Container Registry for Docker images.
- GitHub Secrets configured:
  - `DOCKER_USERNAME` - Docker Hub username
  - `DOCKER_PASSWORD` - Docker Hub token
  - `EC2_HOST` - Public IP or hostname of EC2 instance
  - `EC2_SSH_KEY` - Private SSH key for EC2 login

### Ansible

- Created Ansible scripts for server configurations (i.e. Docker installation, swarm initialization, nginx proxy setup, and service creation)
- Attached the nginx.conf file

### Deployment Steps

1. **Clone the repository:**

   ```
   git clone https://github.com/vigneshwaraprabu/yii2-app.git
   cd yii2-app
   ```

2. **Make the required changes and push to main branch**

   ```
   git add .
   git commit -m "Respective commit message"
   git push origin main
   ```
> In this example, changes were pushed directly to the main branch to test the workflow. However, in real-world scenarios, it is recommended to follow best practices by creating a feature branch, making the necessary changes there, and opening a Pull Request (PR) to merge into the main branch after proper review and testing.

3. **Github Actions Workflow Deployment**
   - Workflow will automatically trigger on push to the main branch
   - It will build the Docker image and push it to Docker Hub 
   - The Docker service on EC2 will be updated with the new image 
   - On deployment failure, it will automatically rollback to the previous image 


### Verify Deployment

- SSH into EC2 and check Docker services:
    ```
    ssh ec2-user@<EC2_HOST>
    docker service ls
    docker service inspect yii2_web --format '{{.Spec.TaskTemplate.ContainerSpec.Image}}'
    ```
- Access the application at:
    ```
    http://<EC2_HOST>:80
    ```



