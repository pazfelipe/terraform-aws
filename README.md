# AWS Terraform Infrastructure Project

This repository contains the infrastructure as code (IaC) using Terraform to configure and manage various AWS resources. The project is structured to facilitate the configuration of different environments and projects, with options to include or exclude modules as needed.

This project has been developed to help manage EKS-based environments, however, you can adjust it to use other resources, from EC2 instances to lambda functions, provided you configure the necessary tools.

## Project Structure

```bash
.
├── README.md
└── aws
    ├── modules
    │   ├── cloud-watch
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   ├── credentials
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   ├── eks
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   ├── role-bindings.tf
    │   │   └── variables.tf
    │   ├── iam
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   ├── internet-gateway
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   ├── nat-gateway
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   ├── node-group
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   ├── plugins
    │   │   ├── argocd.tf
    │   │   ├── controller-trust-policy.json
    │   │   ├── external-secrets.tf
    │   │   ├── iam-oicd.tf
    │   │   ├── karpenter-controller-role.tf
    │   │   ├── karpenter.tf
    │   │   ├── nginx-ingress.tf
    │   │   ├── provider.tf
    │   │   ├── skater-reloader.tf
    │   │   ├── values
    │   │   │   ├── argocd-role-binding.yaml
    │   │   │   └── argocd.yaml
    │   │   └── variables.tf
    │   ├── route-table
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   ├── subnetwork
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   └── vpc
    │       ├── main.tf
    │       ├── output.tf
    │       └── variables.tf
    └── staging
        ├── project-x
        │   ├── locals.tf
        │   ├── main.tf
        │   ├── output.tf
        │   ├── providers.tf
        │   ├── values
        │   │   ├── README.md
        │   │   ├── argocd-cm.yaml
        │   │   ├── argocd-rbac-cm.yaml
        │   │   ├── aws-auth.yaml
        │   │   ├── editor-pod-role.yaml
        │   │   ├── editor-role-binding.yaml
        │   │   ├── readonly-pod-role.yaml
        │   │   └── readonly-role-binding.yaml
        │   └── variables.tf
        └── shared
            ├── aws_s3.tf
            ├── data.tf
            ├── db_instances.tf
            ├── locals.tf
            ├── outputs.tf
            ├── providers.tf
            ├── secret_manager.tf
            ├── user_groups.tf
            ├── users.tf
            └── variables.tf
```

## Technologies Used

- **ArgoCD**: A declarative continuous delivery tool for Kubernetes.
- **Helm**: The Kubernetes chart manager.
- **Karpenter**: A node provisioning solution for Kubernetes, helping to improve cluster efficiency.
- **Skater-Reloader**: A controller to restart Kubernetes Pods based on changes to ConfigMaps and Secrets.
- **Nginx Controller**: A web server that can also be used as a reverse proxy, load balancer, and more.
- **External-Secrets**: Synchronizes secrets from external secret management services into Kubernetes.

## How to Use the Project

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)
- AWS CLI configured and logged in (ensure your AWS credentials are properly set as per [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html))
- Kubernetes CLI [(kubectl)](https://kubernetes.io/docs/tasks/tools/)

### Setup Steps

1. Clone the repository:
   
```bash
git clone https://github.com/pazfelipe/terraform-aws.git
cd terraform-aws/aws
```

2. Configure the desired modules. If you do not want to use a specific module (e.g., argocd), remove the corresponding file in the plugins folder and remove its reference in the main.tf of project-x.
3. To configure a specific environment (e.g., staging):

```bash
cd staging/project-x
terraform init
terraform plan
terraform apply
```

4. If you want to configure another environment (e.g., production), duplicate the staging directory, rename it to production, change the bucket in the backend to point to the new S3, and adjust the variables and locals as needed.

## Notes on Optional Directories

- Plugins: An optional directory that contains various additional tools and services. Each plugin can be removed simply by deleting its file and removing its reference in the project’s [main.tf](/aws/staging/project-x/main.tf).
- Shared: A directory serving as an example for resources that are not part of the main project, such as MySQL databases or S3 buckets. Like the plugins directory, shared is optional and can be completely removed or have its items deleted. This directory has a separate tfstate from project-x.
- Terraform can use local or remote state. To use local state, simply keep the backend commented out or remove it from the providers, [project-x](/aws/staging/project-x/providers.tf), for example. To use remote state, uncomment the backend and point it to the correct bucket.

## Contribution

Feel free to open issues or submit pull requests for improvements and corrections. All contributions are welcome!