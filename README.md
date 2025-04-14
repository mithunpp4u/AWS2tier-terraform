Absolutely! Here's the final version of the `README.md` with the architecture diagram from the provided GitHub link included in the **Architecture** section:

---

# 🌩️ AWS 2-Tier Architecture using Terraform (Mini Project)

This mini project sets up a modular 2-tier cloud infrastructure on **AWS** using **Terraform**, just for fun and skill-building outside of work.

---

## 🏠 Architecture Diagram

![Architecture](https://github.com/AnkitJodhani/3rdWeekofCloudOps/blob/main/architecture.gif?raw=true)

> _Image Source: [Ankit Jodhani](https://github.com/AnkitJodhani)_

---

## 🧾 Variables Required

You’ll need to define the following variables in your `terraform.tfvars` file (or via CLI/environment variables) before deployment:

### 🔧 General Configuration
- `project_name`: Name for organizing and tagging resources  
- `region`: AWS region to deploy infrastructure (e.g., `us-east-1`)

### 🌐 VPC & Subnets
- `vpc_cidrblk`: CIDR block for the VPC  
- `pb_sub1_cidrblk`: Public subnet 1  
- `pb_sub2_cidrblk`: Public subnet 2  
- `pr_sub1_cidrblk`: Private subnet 1  
- `pr_sub2_cidrblk`: Private subnet 2  
- `pr_sub3_cidrblk`: Private subnet 3 (for DB)  
- `pr_sub4_cidrblk`: Private subnet 4 (for DB)

### 💻 EC2 Auto Scaling Group (Web Tier)
- `instance_type`: Type of EC2 instance to use (e.g., `t3.micro`)  
- `web_ami`: AMI ID for your web server  
- `min_size`: Minimum number of EC2 instances  
- `max_size`: Maximum number of EC2 instances  
- `desired_cap`: Desired capacity of the Auto Scaling Group  
- `health_check_type`: Health check type (e.g., `EC2`, `ELB`)

### 🛢️ RDS (Database Tier)
- `db_name`: Name of the database  
- `db_sub_name`: DB subnet group name  
- `db_username`: Master DB username  
- `db_password`: Master DB password

### 🔐 ACM (SSL/TLS Certificate)
- `certificate_domain_name`: Domain name for issuing the certificate (must be verified via Route53)  
- `additional_domain_name`: Optional (e.g., `www.example.com`) to include in the certificate

> 💡 Make sure the ACM certificate is in the **N. Virginia (`us-east-1`)** region for compatibility with CloudFront.

### 🌍 Route 53 (DNS Management)
- A **public hosted zone** must exist in AWS Route 53  
- The domain names used in ACM must be pointed to this zone  
- Route53 module uses outputs from CloudFront for DNS routing

---

## 🚀 How to Deploy

1. Create an **S3 bucket** (with versioning) and a **DynamoDB table** for remote state management.
2. Verify your domain with **ACM** and ensure a certificate is in the `Issued` state.
3. Set up a **public hosted zone** in **Route53** for your domain.
4. Populate the `terraform.tfvars` file with the variables listed above.
5. Run the following:

```bash
terraform init
terraform plan
terraform apply
```

> Type `yes` to confirm and deploy your infrastructure.


