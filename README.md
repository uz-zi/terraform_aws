# Infrastructure Setup Documentation – Terraform on AWS

## Part 1: Infrastructure Setup Documentation

## 1. Objective
Automate the provisioning of cloud infrastructure required to host the server instance.

## 2. Tools and Technologies Used
- **Terraform**: Infrastructure as Code (IaC) tool to provision AWS resources.  
- **AWS EC2**: Virtual server instance in AWS to host the application.  
- **AWS Security Groups**: Firewall rules to control inbound and outbound traffic.  
- **AWS Key Pair**: SSH keys for secure access to EC2 instances.  

## 3. Prerequisites

#### 3.1 Install Terraform on Windows
1. Download Terraform from the official site:  
   https://developer.hashicorp.com/terraform/install  
2. Extract `terraform.exe` and add its location to your **Windows PATH** environment variable.  
3. Verify installation by running in Command Prompt or Git Bash:  
   ```bash
   terraform -v

#### 3.2 Generate SSH Key Pair on Windows

To access your EC2 instance securely, generate an SSH key pair using Git Bash:

1. **Open Git Bash terminal**
2. **Run the following command:**

   ```bash
   ssh-keygen -t rsa

3. **it will ask you the path**

   ```bash
   ./id_rsa

5.	**This generates:**

      ```bash
      id_rsa (private key) — keep it safe.
      id_rsa.pub (public key) — upload this to AWS.

#### 3.3 Provider Configuration (provider.tf)
- Uses the AWS provider file to deploy resources in the **eu-north-1** region.
- AWS access keys are provided for authentication.

#### 3.4 Security Group Configuration
- Allows inbound SSH access on **port 22** from anywhere (`0.0.0.0/0`).
- Allows inbound traffic on **port 80** to enable connectivity for the Docker image.
- Allows all outbound traffic.

#### 3.5 EC2 Instance Resource (instance.tf)
- Launches an **EC2 t3.micro** instance using the specified AMI.
- Uses the created key pair for SSH access.
- Associates the instance with the configured security group.

## 4. Terraform Workflow Commands

#### 4.1 Initialize Terraform

Run this command once to initialize your working directory. This will download the necessary provider plugins (e.g., AWS):

```bash
terraform init
```

#### 4.2 Plan the Deployment
See what Terraform will create or modify without applying:
```bash
terraform plan
```

#### 4.3 Apply Changes (Provision Resources)
Create the resources defined in your .tf files:
```bash
terraform apply
```

You will be prompted to confirm before Terraform creates resources.


## 5. Outputs and Access
-	Key Pair Name: Terraform outputs the name of the SSH key pair created.
-	EC2 Public IP: Can be obtained from AWS Console or by adding an output in Terraform for convenience.

## 6. Summary
You have successfully automated provisioning of an AWS EC2 instance using Terraform with:
-	Configured provider and credentials
-	Created SSH key pair resource
-	Set up a security group for SSH
-	Launched EC2 instance with specified AMI and instance type


## Part 3: Docker Container and Image Deployment
[ Docker image Deployment to Dockerhub](https://github.com/uz-zi/Netwroking_Project)

## Part 2: Configuration Management with Ansible
[Anisble setup to pull the Docker image on the EC2 server](https://github.com/uz-zi/terraform_aws)

## Part 4: CI/CD Pipeline Integration to pull the image on the EC2 instance whenever code is pushed
[Git actions for pipeline](https://github.com/uz-zi/Netwroking_Project)
