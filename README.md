# GCP Airflow VM with Terraform

This project provisions a single Ubuntu VM on Google Cloud Platform using Terraform and cloud-init. The VM automatically installs Docker, Docker Compose, and sets up Airflow using the official installation methods.

## 🚀 What it creates
- An Ubuntu 22.04 LTS VM on GCP (15GB disk, e2-standard-2)
- Docker and Docker Compose installed using official methods
- Airflow running in Docker containers

The VM uses `user-data.yaml` to:
- Create user `gary` with your SSH public key
- Install Docker and Docker Compose using official installation scripts
- Add user to docker group for proper permissions
- Clone your Airflow repository
- Start Airflow with Docker Compose

---

## 📂 Project Structure
- `main.tf` → Defines GCP VM resource
- `variables.tf` → Configuration variables
- `prod.tfvars` → Your GCP deployment values
- `outputs.tf` → Shows VM IP + SSH command
- `user-data.yaml` → Cloud-init bootstrap script

---

## 🔑 Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- A GCP project with billing enabled
- Your SSH key pair (`~/.ssh/gcp` and `~/.ssh/gcp.pub`)

---

## ⚙️ Usage

### Deploy the VM
```bash
terraform init
terraform apply -var-file="prod.tfvars"
```

### Connect to your VM
After deployment, use the SSH command from the output:
```bash
ssh -i ~/.ssh/gcp gary@<VM_IP>
```

### Verify Installation
Once connected to the VM:
```bash
# Test Docker
docker run hello-world

# Test Docker Compose
docker compose version

# Check Airflow status
cd /home/gary/airflow-setup
docker compose ps
```

---

## 🧹 Cleanup
Destroy resources when done:
```bash
terraform destroy -var-file="prod.tfvars"
```

---

## 📌 Notes
- The VM uses official Docker installation methods for better reliability
- User `gary` is automatically added to the docker group
- Airflow starts automatically after VM creation
- SSH key is added via GCP metadata (ensure `~/.ssh/gcp.pub` exists)
- VM has 15GB disk and e2-standard-2 machine type by default

## 🔧 Customization
Edit `prod.tfvars` to customize:
- `vm_name` → VM name
- `vm_machine_type` → Machine type (e.g., e2-medium, e2-standard-4)
- `vm_disk_size_gb` → Disk size in GB
- `zone` → GCP zone
- `ssh_user` → Username to create