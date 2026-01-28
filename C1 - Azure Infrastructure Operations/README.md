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

📸 A screenshot of this output is included below and in the repository as required.
<img width="935" height="392" alt="Screenshot 2026-01-26 195141" src="https://github.com/user-attachments/assets/0e730435-388c-41a8-a62e-8636489e04a9" />

<img width="1095" height="516" alt="Screenshot 2026-01-27 002735" src="https://github.com/user-attachments/assets/0ec34968-f580-473d-985c-a744e85399f4" />



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
### Screenshots on validating and building successfully.

<img width="1730" height="93" alt="Screenshot 2026-01-27 162027" src="https://github.com/user-attachments/assets/319f64af-2131-424f-923d-5ccf8a0dd1a7" />

<img width="1870" height="417" alt="Screenshot 2026-01-27 165812" src="https://github.com/user-attachments/assets/d8eaf155-50be-43f2-8580-bc1d8a657ff9" />

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
## Screenshots showing some of the infrastructure deployed
---
<img width="1855" height="779" alt="Screenshot 2026-01-27 172438" src="https://github.com/user-attachments/assets/fb69b9d4-d732-4499-af67-603027ad0ad5" />

<img width="1884" height="856" alt="Screenshot 2026-01-27 172107" src="https://github.com/user-attachments/assets/891190dc-d422-4ab4-b516-076dd9742ba4" />

## ✅ Summary

This project demonstrates:

* Secure and governed Azure deployments
* Reusable image creation with Packer
* Scalable infrastructure provisioning with Terraform
* Best practices for Infrastructure as Code

---

