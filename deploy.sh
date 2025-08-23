#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    local missing_tools=()
    
    if ! command_exists terraform; then
        missing_tools+=("terraform")
    fi
    
    if ! command_exists kubectl; then
        missing_tools+=("kubectl")
    fi
    
    if ! command_exists ssh-keygen; then
        missing_tools+=("ssh-keygen")
    fi
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        print_error "Missing required tools: ${missing_tools[*]}"
        print_status "Please install the missing tools and run this script again."
        exit 1
    fi
    
    print_success "All prerequisites are met!"
}

# Generate SSH keys for FluxCD
generate_ssh_keys() {
    print_status "Generating SSH keys for FluxCD Git repository access..."
    
    local ssh_key_path="./flux-ssh-key"
    
    if [ ! -f "$ssh_key_path" ]; then
        ssh-keygen -t rsa -b 4096 -f "$ssh_key_path" -N "" -C "flux-cd@ionos-k8s-cluster"
        print_success "SSH keys generated successfully!"
        
        print_warning "IMPORTANT: You need to add the following public key to your GitHub repository as a deploy key:"
        echo ""
        cat "${ssh_key_path}.pub"
        echo ""
        print_warning "Steps to add the deploy key:"
        print_status "1. Go to your GitHub repository: https://github.com/samuelbartels20/ionos"
        print_status "2. Click on Settings -> Deploy keys"
        print_status "3. Click 'Add deploy key'"
        print_status "4. Give it a title like 'FluxCD Deploy Key'"
        print_status "5. Paste the public key above"
        print_status "6. Check 'Allow write access' if you want FluxCD to commit back to the repo"
        print_status "7. Click 'Add key'"
        echo ""
        read -p "Press Enter after you've added the deploy key to GitHub..."
        
        # Update terraform.tfvars with SSH keys
        print_status "Updating terraform.tfvars with SSH keys..."
        
        # Escape the private key for terraform
        private_key=$(cat "$ssh_key_path" | sed ':a;N;$!ba;s/\n/\\n/g')
        public_key=$(cat "${ssh_key_path}.pub")
        
        # Update the terraform.tfvars file
        sed -i.bak "s|# git_private_key = \".*\"|git_private_key = \"$private_key\"|" infrastructure/terraform.tfvars
        sed -i.bak "s|# git_public_key = \".*\"|git_public_key = \"$public_key\"|" infrastructure/terraform.tfvars
        
        print_success "SSH keys added to terraform.tfvars"
    else
        print_status "SSH keys already exist, skipping generation"
    fi
}

# Update configuration
update_config() {
    print_status "Updating configuration..."
    
    # Ask for backup email
    current_email=$(grep "backup_email" infrastructure/terraform.tfvars | cut -d'"' -f2)
    if [ "$current_email" = "admin@example.com" ]; then
        read -p "Enter your email for backup notifications: " backup_email
        sed -i.bak "s|backup_email = \"admin@example.com\"|backup_email = \"$backup_email\"|" infrastructure/terraform.tfvars
        print_success "Backup email updated to: $backup_email"
    fi
}

# Deploy infrastructure
deploy_infrastructure() {
    print_status "Deploying IONOS Cloud infrastructure..."
    
    cd infrastructure
    
    # Initialize Terraform
    print_status "Initializing Terraform..."
    terraform init
    
    # Plan the deployment
    print_status "Planning Terraform deployment..."
    terraform plan -out=tfplan
    
    # Ask for confirmation
    echo ""
    print_warning "Review the Terraform plan above."
    read -p "Do you want to proceed with the deployment? (y/N): " confirm
    
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        print_status "Deployment cancelled."
        exit 0
    fi
    
    # Apply the plan
    print_status "Applying Terraform configuration..."
    terraform apply tfplan
    
    print_success "Infrastructure deployment completed!"
    
    cd ..
}

# Configure kubectl
configure_kubectl() {
    print_status "Configuring kubectl..."
    
    if [ -f "infrastructure/kubeconfig" ]; then
        export KUBECONFIG="$(pwd)/infrastructure/kubeconfig"
        print_success "kubectl configured with cluster credentials"
        
        # Test connection
        print_status "Testing cluster connection..."
        kubectl cluster-info
        print_success "Successfully connected to the cluster!"
    else
        print_error "kubeconfig file not found. Infrastructure deployment may have failed."
        exit 1
    fi
}

# Wait for FluxCD to be ready
wait_for_flux() {
    print_status "Waiting for FluxCD to be ready..."
    
    # Wait for flux-system namespace
    kubectl wait --for=condition=Ready pods -l app.kubernetes.io/name=flux-source-controller -n flux-system --timeout=300s
    kubectl wait --for=condition=Ready pods -l app.kubernetes.io/name=flux-kustomize-controller -n flux-system --timeout=300s
    kubectl wait --for=condition=Ready pods -l app.kubernetes.io/name=flux-helm-controller -n flux-system --timeout=300s
    
    print_success "FluxCD is ready!"
}

# Check deployment status
check_deployment_status() {
    print_status "Checking deployment status..."
    
    echo ""
    print_status "=== Cluster Nodes ==="
    kubectl get nodes -o wide
    
    echo ""
    print_status "=== FluxCD Status ==="
    kubectl get pods -n flux-system
    
    echo ""
    print_status "=== GitRepository Status ==="
    kubectl get gitrepository -n flux-system
    
    echo ""
    print_status "=== Kustomization Status ==="
    kubectl get kustomization -n flux-system
    
    echo ""
    print_status "=== Infrastructure Namespaces ==="
    kubectl get namespaces
    
    print_success "Deployment status check completed!"
}

# Main deployment function
main() {
    echo ""
    print_status "🚀 Starting IONOS Cloud Kubernetes Cluster Deployment"
    print_status "===================================================="
    echo ""
    
    check_prerequisites
    generate_ssh_keys
    update_config
    deploy_infrastructure
    configure_kubectl
    wait_for_flux
    check_deployment_status
    
    echo ""
    print_success "🎉 Deployment completed successfully!"
    print_status "===================================="
    echo ""
    print_status "Next steps:"
    print_status "1. Your Kubernetes cluster is now running with:"
    print_status "   - 3 node pools (system, application, monitoring)"
    print_status "   - IONOS Managed PostgreSQL database"
    print_status "   - IONOS Managed Redis cache"
    print_status "   - FluxCD for GitOps"
    print_status "   - Backup services configured"
    echo ""
    print_status "2. FluxCD will automatically deploy infrastructure components from:"
    print_status "   - ./kubernetes/infrastructure/production/"
    echo ""
    print_status "3. To monitor the deployment:"
    print_status "   - kubectl get pods -A"
    print_status "   - kubectl logs -f deployment/flux-source-controller -n flux-system"
    echo ""
    print_status "4. Your kubeconfig is available at: infrastructure/kubeconfig"
    print_status "   Export it: export KUBECONFIG=$(pwd)/infrastructure/kubeconfig"
    echo ""
    print_warning "Remember to keep your SSH keys and terraform state secure!"
}

# Run main function
main "$@" 