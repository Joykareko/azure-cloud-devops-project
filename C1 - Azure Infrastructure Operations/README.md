# Azure Infrastructure Deployment with Packer and Terraform

This project demonstrates how to build a reusable Azure VM image using **Packer** and deploy scalable infrastructure using **Terraform**, following Infrastructure as Code (IaC) best practices.

The solution was built as part of an Azure Infrastructure Operations project and includes Azure Policy enforcement, image creation, and automated infrastructure deployment.

---

## 📌 Project Overview

The goal of this project is to:

* Enforce Azure governance using a **mandatory tags policy**
* Build a **custom Ubuntu 18.04 LTS VM image** using Packer
* Deploy infrastructure using **Terraform**, including:

  * Virtual Network
  * Load Balancer
  * Multiple Linux Virtual Machines
* Make the deployment **configurable** using variables
* Ensure the solution is suitable for **CI/CD pipelines**

---

## 🛠️ Tools & Technologies

* **Azure CLI** – Authentication and policy verification
* **Azure Policy** – Enforce mandatory resource tagging
* **Packer** – Build reusable VM images
* **Terraform** – Provision and manage infrastructure
* **Ubuntu 18.04 LTS** – Base OS image

---

## 📁 Repository Structure

```
.
├── starter_files/
│   └── server.json
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   └── outputs.tf
└── README.md
```

---

## 🔐 Azure Policy Verification

Before deploying infrastructure, we verify that the **mandatory tags policy** is present:

```bash
az policy definition list --query "[].name"
```

Sample output:

```
[
  "enforce-mandatory-tags",
  "clouddevops674-295132-PolicyDefinition",
  "SecurityCenterBuiltIn"
]
```

📸 A screenshot of this output is included in the repository as required.

---

## 🖼️ Packer Image Creation

### Image Details

* **OS**: Ubuntu 18.04 LTS
* **Provisioning**:

  * Simple web server
  * Serves a static `index.html`

### Build the Image

```bash
packer init .
packer validate server.json
packer build server.json
```

### Output

The image is created as a **Managed Image** in Azure:

```
ManagedImageName: ubuntu-web-image
ManagedImageResourceGroupName: Azuredevops
```

---

## 🧱 Terraform Infrastructure Deployment

Terraform uses the Packer image to deploy the infrastructure.

### Key Components

* Virtual Network & Subnet
* Network Security Group
* Load Balancer
* Multiple Linux Virtual Machines

### Configurable Variables

Customers can configure:

* Number of virtual machines
* Deployment location
* VM size
* SSH public key path

Example (`terraform.tfvars`):

```hcl
vm_count = 2
location = "westeurope"
vm_size = "Standard_B1s"
ssh_public_key_path = "id_rsa.pub"
```

---

## 🚀 Deployment Steps

### Initialize Terraform

```bash
terraform init
```

### Create Execution Plan

```bash
terraform plan -out=solution.plan
```

### Apply the Plan

```bash
terraform apply solution.plan
```

---

## 📤 Outputs

After deployment, Terraform outputs:

* Load Balancer public IP address
* Resource group name

These outputs can be used to verify the application is accessible.

---

## 🔎 Validation

* The application is accessible via the **Load Balancer IP**
* Resources comply with the **mandatory tags policy**
* Infrastructure can be destroyed and recreated reliably

---

## 🧹 Cleanup

To destroy all deployed infrastructure:

```bash
terraform destroy
```

---

## ✅ Summary

This project demonstrates:

* Secure and governed Azure deployments
* Reusable image creation with Packer
* Scalable infrastructure provisioning with Terraform
* Best practices for Infrastructure as Code

---

