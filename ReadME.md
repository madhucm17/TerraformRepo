# Terraform Infrastructure as Code (IaC) Setup for AWS

## 📌 Why Infrastructure as Code (IaC)?

Before IaC, managing infrastructure was:

* **Manual Server Setup**: Servers and other resources were set up manually, leading to human error and inconsistent environments.
* **Too Much Documentation**: Steps were maintained in long documents, which often got outdated.
* **Basic Automation Only**: Scripts helped a bit, but lacked flexibility and control.
* **Slow Process**: Provisioning took time, as everything was done manually step-by-step.

With IaC tools like **Terraform**:

* Infrastructure setup becomes reusable and manageable as code.
* Reduces time, errors, and inconsistencies.
* All changes can be tracked, versioned, and automated.

---

## 🚀 Why Use Terraform?

* **Multi-Cloud Support**: Terraform works across AWS, Azure, Google Cloud, and even on-prem. One tool for all providers.
* **Modules and Providers**: Rich ecosystem of ready-made modules to speed up development.
* **Simple Syntax (HCL)**: Easy-to-read HashiCorp Configuration Language.
* **State Management**: Tracks infrastructure with a `.tfstate` file to prevent duplication or misconfiguration.
* **Execution Plan**: Allows previewing changes with `terraform plan` before applying.
* **Tool Integrations**: Integrates well with Jenkins, Docker, Kubernetes, and Ansible.
* **Readable for Teams**: Even non-developers can understand and collaborate.

---

## 🛠️ Terraform Installation on Linux

```bash
# Step 1: Update system
sudo apt update

# Step 2: Install dependencies
sudo apt install -y curl gnupg software-properties-common

# Step 3: Add HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Step 4: Add Terraform repo
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Step 5: Update again
sudo apt update

# Step 6: Install Terraform
sudo apt install terraform -y

# Step 7: Verify
terraform -version
```

---

## ☁️ Setup Terraform for AWS

### Step 1: Install AWS CLI

* Download from: [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)

### Step 2: Create an IAM User in AWS

* Give programmatic access with necessary permissions.

### Step 3: Configure AWS CLI

```bash
aws configure
```

Enter:

* Access Key ID
* Secret Access Key
* Default Region (e.g. `ap-south-1`)

---

## 🧾 Sample Terraform File

### 📁 Folder Structure

```
/terraform
├── main.tf
```

### ✍️ main.tf

```hcl
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
  ami                    = "<AMI-ID>"
  instance_type          = "t2.micro"
  key_name               = "<YOUR-KEY-NAME>"
  subnet_id              = "<SUBNET-ID>"
  vpc_security_group_ids = ["<SG-ID>"]
}
```

---

## ⚙️ Terraform Commands

1. `terraform init`

   * Initializes the working directory and downloads required providers.

2. `terraform plan`

   * Previews what Terraform will do without making changes.

3. `terraform apply`

   * Applies the changes and provisions infrastructure.

4. `terraform destroy`

   * Tears down all managed infrastructure.

---

## 🔌 What is a Provider?

A **Terraform Provider** is a plugin that allows Terraform to interact with cloud providers or services (like AWS, Azure, etc).

### Example:

```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myserver" {
  ami           = "<AMI-ID>"
  instance_type = "t2.micro"
  tags = {
    Name = "TerraformServer"
  }
}
```

### Popular Providers:

* `aws` – Amazon Web Services
* `azurerm` – Microsoft Azure
* `google` – Google Cloud Platform
* `kubernetes` – Kubernetes
* `docker` – Docker
* `github` – GitHub

Browse more: [https://registry.terraform.io/browse/providers](https://registry.terraform.io/browse/providers)

---

## 🌍 Multiple Provider Setup

When managing **multi-cloud or cross-account setups**, you can define multiple providers.

### Step 1: Create `providers.tf`

```hcl
provider "aws" {
  region = "us-east-1"
}

provider "azurerm" {
  subscription_id = "<azure-subscription-id>"
  client_id       = "<azure-client-id>"
  client_secret   = "<azure-client-secret>"
  tenant_id       = "<azure-tenant-id>"
}
```

### Step 2: Use in `main.tf`

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "t2.micro"
}

resource "azurerm_virtual_machine" "example" {
  name     = "example-vm"
  location = "eastus"
  size     = "Standard_A1"
}
```

---



> ✅ Feel free to clone this repo and try it yourself. Contributions welcome!
