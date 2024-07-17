# Kubernetes Configuration Files

This repository contains configuration files for managing users and permissions in ArgoCD and the EKS cluster.

## Files

- `argocd-cm.yaml`: Configuration for managing users in ArgoCD.
- `argocd-rbac-cm.yaml`: RBAC (Role-Based Access Control) configuration for managing user permissions in ArgoCD.
- `aws-auth.yaml`: Authentication configuration for managing user access to the EKS cluster.
- `editor-pod-role.yaml`: Defines specific permissions for users with the editor role in the EKS cluster.
- `editor-role-binding.yaml`: Role binding to link users to the editor role in the EKS cluster.
- `readonly-pod-role.yaml`: Defines specific permissions for users with the read-only role in the EKS cluster.
- `readonly-role-binding.yaml`: Role binding to link users to the read-only role in the EKS cluster.

## File Descriptions

### ArgoCD Configurations

- **argocd-cm.yaml**
  - Manages ArgoCD configurations and users.
  
- **argocd-rbac-cm.yaml**
  - Defines permissions and access rules for ArgoCD users.

### EKS Cluster Configurations

- **aws-auth.yaml**
  - Manages user authentication and access permissions for the EKS cluster.
  
- **editor-pod-role.yaml**
  - Defines the editor role with specific permissions to manipulate pods in the EKS cluster.
  
- **editor-role-binding.yaml**
  - Links users to the editor role, applying the permissions defined in `editor-pod-role.yaml`.

- **readonly-pod-role.yaml**
  - Defines the read-only role with specific permissions to view pods in the EKS cluster.
  
- **readonly-role-binding.yaml**
  - Links users to the read-only role, applying the permissions defined in `readonly-pod-role.yaml`.

## How to Apply

To apply these configurations to your cluster, use the following Terraform command:

```bash
terraform plan
```

Check if the changes are the expected ones. After you have validated them, run:

```bash
terraform apply
```
