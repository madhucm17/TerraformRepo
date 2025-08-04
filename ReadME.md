## Terraform 
Before using Infrastructure as Code (IaC), managing infrastructure was a lot of manual work Here  how things used to be:
•	Manual Server Setup: We had to set up servers and other resources manually, which sometimes caused mistakes or differences between environments
•	Too Much Documentation: We had to write and follow long documents to repeat the setup steps, but those documents often became outdated
•	Basic Automation Only: We used simple scripts, but they didn’t give us the flexibility or control we get today
•	Slow Process: Setting up new environments or resources used to take a lot of time because everything was done step by step manually




Now, with IaC tools like Terraform, CloudFormation, and others
•	We can write the setup as code and reuse it whenever needed
•	It saves time, avoids mistakes and makes the setup more reliable
•	Changes are easy to track and manage just like code




why we using Terraform instead of other IaC tools:
•	We Can Works with Multiple Cloud Providers: One of the best things about Terraform is that I can use it for AWS, Azure, Google Cloud, or even on-prem servers I don’t  have to learn a different tool for each provider  just one code works across all so in this case it’s a master 
•	Lots of Ready-Made Modules: Terraform has a big collection of modules and providers already created by others. So instead of writing everything from scratch, I can use existing code and save a lot of time
•	Easy-to-Understand Syntax: Terraform uses simple code (HCL) that lets me write what I want the final setup to look like I just describe the goal and Terraform figures out how to get there
•	Tracks Infrastructure State: It keeps a state file that remembers what resources have been created. This helps Terraform know what’s already there and what needs to change it won’t create duplicates or mess things up
•	Preview Before Changes: Before making any changes, Terraform lets me run terraform plan to see what will happen. That way, I can double-check everything before applying it.
•	Works Well with Other Tools: I can connect Terraform with tools like Jenkins, Docker, Kubernetes, and Ansible. This helps build full automation pipelines easily.
•	Simple Language (HCL): The language it uses is easy to read and write, even for someone who’s not a full-time developer. That makes it easier for teams to collaborate.




Installation:
Step 1: Update The System 
sudo apt update 

Step 2: install required packages 
sudo apt install -y curl gnupg software-properties-common

Step 3: Add the Harshicorp GPG Key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

Step 4: Add the Harshicorp Linux Repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

Step 5: Again Update the System
Sudo apt update

Step 6: Install the Monster Terraform
sudo apt install terraform -y

Step 7: Verify The Installation 
terraform -version







The Main Step Setup Terraform For AWS 
Step 1: Install AWS CLI (Command Line Interface)
you can download and install it from the AWS CLI download page.

Step 2: Create an AWS IAM User
to interact with AWS programmatically you should create an IAM (Identity and Access Management) user with appropriate permissions

Step 3: Configure AWS CLI Credentials
aws configure – “using this command”

Go to Your Code Editor and Create one Folder /terraform inside create one file main.tf “Terraform extension is .tf” 
       
 terraform {
          required_providers {
            aws = {
              source = "hashicorp/aws"
              version = "~> 3.76" 
            }
          }
        }

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "TerraformServer" {
    ami          = "Add Your AMI ID " 
    instance_type = "t2.micro"
    key_name     = "Add ur Key "  
    subnet_id = "Add Your Public Subnet id"
    vpc_security_group_ids = ["Add Your SG ID"]
}

When You Run this File You must know about this Commands 
1.	Terraform init
2.	Terraform plan 
3.	Terraform apply 
4.	Terraform Destroy

Terraform Init: Initialize Terraform
What it does:
•	Downloads the required provider plugin (in this case, AWS)
•	Sets up your working directory

Terraform Plan: Preview Changes
What it does:
•	Shows what Terraform will do without actually doing it
•	Helps you verify before making real changes

Terraform Apply:  its Started to Create the Resources
What it does:
•	Applies the changes and creates (or updates) the infrastructure	
•	Prompts you to type yes before proceeding

Terraform Destroy: Delete the Resources
What it does:
•	Deletes the resources that Terraform created

Screen Shots: 

 

 

 


 

Provider : 
Terraform a provider is like a allows Terraform to interact with different platforms like cloud services (AWS, Azure, GCP)
Basically providers act as the bridge between Terraform and the services we want to manage Without a provider, Terraform wouldn't know how or where to create your infrastructure

How Its Works: 
When you write Terraform code you define which provider you want to use Terraform will then automatically download the plugin for that provider and use it to manage resources
Ex:
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myserver" {
  ami          = "ur Id" 
  instance_type = "t2.micro"
  tags = {
    Name = "TerraformServer"
  }
}
What is Does1:
first we tell Terraform to use the AWS provider in the Mumbai region (Ap-south-1)
Then we create a simple EC2 instance using that provider.
When we run Terraform commands (init, plan, apply), Terraform talks to AWS through the provider and creates the instance

Other Common Provider:
•	azurerm – For Microsoft Azure
•	google – For Google Cloud Platform
•	kubernetes – For managing K8s clusters
•	github – For managing GitHub repos and users
•	docker – For managing Docker containers
•	vsphere – For managing VMware
   https://registry.terraform.io/browse/providers

Multiple Provider:
In Terraform we use multi-provider configuration when we want to interact with multiple cloud platforms or services in a single configuration  Each provider represents a different API or service (like AWS, Azure, GitHub)

Why we use this:
Multi-Cloud Deployment: Deploying resources across AWS and Azure or other cloud platforms in the same project
Different Accounts/Regions: Managing resources in different AWS accounts or regions
Cross-Platform Integration: For example provisioning infrastructure on AWS and configuring DNS on Cloudflare

Example Configuration for Multiple Provider:
Step 1: Create one New file Like Provider.tf
Step 2: In the providers.tf file define the AWS and Azure providers for example

Provider.tf 
provider "aws" {
  region = "us-east-1"
}




provider "azurerm" {
  subscription_id = "your-azure-subscription-id"
  client_id = "your-azure-client-id"
  client_secret = "your-azure-client-secret"
  tenant_id = "your-azure-tenant-id"
}

In our Main tf or Terraform Configuration File we can use the both aws and azure for Creating the Resources

resource "aws_instance" "example" {
  ami = "ami-0123456789abcdef0"
  instance_type = "t2.micro"
}

resource "azurerm_virtual_machine" "example" {
  name = "example-vm"
  location = "eastus"
  size = "Standard_A1"
}



