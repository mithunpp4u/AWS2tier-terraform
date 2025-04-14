
# 🌩️ AWS 2-Tier Architecture using Terraform (Mini Project)

This mini project sets up a modular 2-tier cloud infrastructure on **AWS** using **Terraform**, just for fun and skill-building outside work.

---

## 🧾 Variables Required

You’ll need to define the following variables in your `terraform.tfvars` file or pass them via CLI/environment variables before deployment:

---

### 🔧 General Configuration
- `project_name`: Name for organizing and tagging resources  
- `region`: AWS region to deploy infrastructure (e.g., `us-east-1`)

---

### 🌐 VPC & Subnets
- `vpc_cidrblk`: CIDR block for the VPC  
- `pb_sub1_cidrblk`: Public subnet 1  
- `pb_sub2_cidrblk`: Public subnet 2  
- `pr_sub1_cidrblk`: Private subnet 1  
- `pr_sub2_cidrblk`: Private subnet 2  
- `pr_sub3_cidrblk`: Private subnet 3 (for DB)  
- `pr_sub4_cidrblk`: Private subnet 4 (for DB)

---

### 💻 EC2 Auto Scaling Group (Web Tier)
- `instance_type`: Type of EC2 instance to use (e.g., `t3.micro`)  
- `web_ami`: AMI ID for your web server  
- `min_size`: Minimum number of EC2 instances  
- `max_size`: Maximum number of EC2 instances  
- `desired_cap`: Desired capacity of the Auto Scaling Group  
- `health_check_type`: Health check type (e.g., `EC2`, `ELB`)

---

### 🛢️ RDS (Database Tier)
- `db_name`: Name of the database  
- `db_sub_name`: DB subnet group name  
- `db_username`: Master DB username  
- `db_password`: Master DB password

---

### 🔐 ACM (SSL/TLS Certificate)
- `certificate_domain_name`: Domain name for issuing the certificate (must be verified via Route53)  
- `additional_domain_name`: Optional (e.g., `www.example.com`) to include in the certificate

📝 **Note:**  
- Ensure the domain is verified and the ACM certificate is in the `Issued` state in **AWS Certificate Manager**  
- The certificate **must be in the N. Virginia region (us-east-1)** for use with **CloudFront**

---

### 🌍 Route 53 (DNS Management)
- A **public hosted zone** should exist in your AWS account  
- Make sure the domain names used in ACM are registered and point to your Route53 zone  
- The Route53 module uses:
  - `cloudfront_domain_name`
  - `cloudfront_hosted_zone_id` (output from the CloudFront module)

---

## 🚀 How to Use

1. Set up the required S3 bucket and DynamoDB table for remote backend state (with versioning enabled).
2. Create and verify an ACM certificate in AWS.
3. Ensure Route53 has a hosted zone for your domain.
4. Populate your `terraform.tfvars` with the variables above.
5. Run:

```bash
terraform init
terraform plan
terraform apply
```

> Type `yes` to confirm and deploy your infrastructure.

---

Let me know if you want this saved as a file or want a version with example values too!
