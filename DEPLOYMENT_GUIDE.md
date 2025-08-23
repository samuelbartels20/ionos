# IONOS Cloud Kubernetes Cluster Deployment Guide

This guide will walk you through deploying a production-ready Kubernetes cluster on IONOS Cloud with all necessary managed services.

## 🏗️ Architecture Overview

Your cluster will include:
- **3 Node Pools**: System (2 nodes), Application (3 nodes), Monitoring (2 nodes)
- **IONOS Managed PostgreSQL**: For WordPress database
- **IONOS Managed Redis**: For caching
- **FluxCD**: For GitOps deployment
- **Load Balancers**: For high availability
- **Backup Services**: For disaster recovery
- **Storage Classes**: SSD, SSD Premium, HDD

## 📋 Prerequisites

Before starting, ensure you have:

1. **IONOS Cloud Account** with sufficient credits
2. **Terraform** (>= 1.0) installed
3. **kubectl** installed
4. **Git** access to your repository
5. **SSH keys** for Git authentication

### Install Prerequisites (Ubuntu/Debian)

```bash
# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

## 🚀 Step-by-Step Deployment

### Step 1: Configure IONOS Credentials

Set your IONOS Cloud credentials as environment variables:

```bash
export IONOS_USERNAME="your-ionos-username"
export IONOS_PASSWORD="your-ionos-password"
```

### Step 2: Generate SSH Keys for FluxCD

```bash
# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f ./flux-ssh-key -N "" -C "flux-cd@ionos-k8s-cluster"

# Display the public key
cat flux-ssh-key.pub
```

### Step 3: Add Deploy Key to GitHub

1. Go to your GitHub repository: https://github.com/samuelbartels20/ionos
2. Click **Settings** → **Deploy keys**
3. Click **Add deploy key**
4. Title: `FluxCD Deploy Key`
5. Paste the public key from Step 2
6. Check **Allow write access** (optional)
7. Click **Add key**

### Step 4: Update Configuration

Edit `infrastructure/terraform.tfvars` and update:

```hcl
# Update your email for backup notifications
backup_email = "your-email@example.com"

# Add your SSH keys (replace with actual keys from Step 2)
git_private_key = "-----BEGIN OPENSSH PRIVATE KEY-----\n...\n-----END OPENSSH PRIVATE KEY-----"
git_public_key = "ssh-rsa AAAAB3NzaC1yc2E..."
```

### Step 5: Deploy Infrastructure

```bash
cd infrastructure

# Initialize Terraform
terraform init

# Review the deployment plan
terraform plan

# Deploy the infrastructure
terraform apply
```

**Expected deployment time: 15-20 minutes**

### Step 6: Configure kubectl

```bash
# Set kubeconfig
export KUBECONFIG=$(pwd)/kubeconfig

# Test connection
kubectl cluster-info
kubectl get nodes
```

### Step 7: Verify FluxCD Deployment

```bash
# Check FluxCD pods
kubectl get pods -n flux-system

# Check GitRepository status
kubectl get gitrepository -n flux-system

# Check Kustomization status
kubectl get kustomization -n flux-system
```

## 🔍 Monitoring Deployment

### Check Infrastructure Components

```bash
# Monitor infrastructure deployment
kubectl get pods -A

# Check ingress-nginx (if deployed via FluxCD)
kubectl get pods -n ingress-nginx

# Check cert-manager (if deployed via FluxCD)
kubectl get pods -n cert-manager

# Check monitoring stack (if deployed via FluxCD)
kubectl get pods -n monitoring
```

### Check Database Connections

```bash
# Check PostgreSQL secret
kubectl get secret postgres-credentials -n wordpress -o yaml

# Check Redis secret
kubectl get secret redis-credentials -n wordpress -o yaml
```

## 📊 Accessing Services

### Database Information

Your managed databases are accessible with the credentials stored in Kubernetes secrets:

- **PostgreSQL**: Available in `postgres-credentials` secret in `wordpress` namespace
- **Redis**: Available in `redis-credentials` secret in `wordpress` namespace

### Load Balancer

The ingress controller will be accessible via the IONOS Load Balancer once infrastructure components are deployed.

## 🔧 Troubleshooting

### Common Issues

1. **FluxCD not syncing**:
   ```bash
   # Check Git repository access
   kubectl logs -n flux-system deployment/source-controller
   
   # Force reconciliation
   flux reconcile source git ionos-repo
   ```

2. **Infrastructure components not deploying**:
   ```bash
   # Check kustomization logs
   kubectl logs -n flux-system deployment/kustomize-controller
   
   # Check if paths exist in repository
   kubectl describe kustomization infrastructure -n flux-system
   ```

3. **Database connection issues**:
   ```bash
   # Check if databases are ready
   terraform output
   
   # Verify secrets are created
   kubectl get secrets -n wordpress
   ```

### Useful Commands

```bash
# Get all resources
kubectl get all -A

# Check FluxCD status
flux get all

# View Terraform outputs
cd infrastructure && terraform output

# Check node resource usage
kubectl top nodes

# Check pod resource usage
kubectl top pods -A
```

## 🔐 Security Considerations

1. **Store SSH keys securely** - Don't commit them to Git
2. **Restrict API access** - Update `api_subnet_allow_list` in terraform.tfvars
3. **Enable RBAC** - FluxCD is configured with proper RBAC
4. **Network policies** - Consider implementing network policies
5. **Pod security policies** - Review and implement as needed

## 🎯 Next Steps

After successful deployment:

1. **Deploy Applications**: Add WordPress and other applications to `kubernetes/applications/`
2. **Configure Monitoring**: Set up Prometheus and Grafana dashboards
3. **Set up CI/CD**: Configure GitHub Actions for automated deployments
4. **Implement Backup Strategy**: Configure regular backups
5. **Domain Configuration**: Set up DNS and SSL certificates

## 📚 Additional Resources

- [IONOS Cloud Documentation](https://docs.ionos.com/cloud/)
- [FluxCD Documentation](https://fluxcd.io/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Terraform IONOS Provider](https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs)

## 🆘 Support

If you encounter issues:

1. Check the troubleshooting section above
2. Review logs using the provided commands
3. Check IONOS Cloud console for resource status
4. Refer to the official documentation links

---

**⚠️ Important**: Keep your SSH keys, Terraform state, and credentials secure. Never commit sensitive information to version control. 