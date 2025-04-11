#Creating VPC and subnets

module "vpc" {
  source = "../modules/vpc"
  project_name = var.project_name
  vpc_cidrblk = var.vpc_cidrblk
  pb_sub1_cidrblk = var.pb_sub1_cidrblk
  pb_sub2_cidrblk = var.pb_sub2_cidrblk
  pr_sub1_cidrblk = var.pr_sub1_cidrblk
  pr_sub2_cidrblk = var.pr_sub2_cidrblk
  pr_sub3_cidrblk = var.pr_sub3_cidrblk
  pr_sub4_cidrblk = var.pr_sub4_cidrblk
}

# Creating NAT

module "nat" {
    source = "../modules/nat"
project_name = var.project_name
pb_sub1_id = module.vpc.pb_sub1_id
pb_sub2_id = module.vpc.pb_sub2_id
pr_sub1_id = module.vpc.pr_sub1_id
pr_sub2_id = module.vpc.pr_sub3_id
pr_sub3_id = module.vpc.pr_sub3_id
pr_sub4_id = module.vpc.pr_sub4_id
internet_gw_id =module.vpc.internet_gw_id
vpc_id = module.vpc.vpc_id
}

module "sg" {
  source = "../modules/sg"
  vpc_id = module.vpc.vpc_id
  project_name = var.project_name

}

module "key" {
    source = "../modules/key"
  
}

module "alb" {
    source = "../modules/alb"
    pb_sub1_id = module.vpc.pb_sub1_id
    pb_sub2_id = module.vpc.pb_sub1_id
    pr_sub1_id = module.vpc.pr_sub1_id
    pr_sub2_id = module.vpc.pr_sub2_id
    vpc_id = module.vpc.vpc_id
    project_name = var.project_name
    alb_sg_id = module.sg.alb_sg_id
    web_sg_id = module.sg.web_sg_id
      
}

module "asg" {
    source = "../modules/asg"
    project_name = var.project_name
    vpc_id = module.vpc.vpc_id
    pr_sub1_id = module.vpc.pr_sub1_id
    pr_sub2_id = module.vpc.pr_sub2_id
    alb_sg_id = module.sg.alb_sg_id
    web_sg_id = module.sg.web_sg_id
    key_name = module.key.key_name
    instance_type = var.instance_type
    web_ami = var.web_ami
    min_size = var.min_size
    max_size = var.max_size
    desired_cap = var.desired_cap
    health_check_type = var.health_check_type
  
}

module "rds" {
    source = "../modules/rds"
    db_name = var.db_name
    db_sub_name = var.db_sub_name
    db_username = var.db_username
    db_password = var.db_password
    db_sg_id = module.sg.db_sg_id
    pr_sub3_id = module.vpc.pr_sub3_id
    pr_sub4_id = module.vpc.pr_sub4_id

}

module "cloudfront" {
    source = "../modules/cloudfront"
    project_name = var.project_name
    certificate_domain_name = var.certificate_domain_name
    additional_domain_name = var.additional_domain_name
    alb_domain_name = var.alb_domain_name
}

module "route53" {
    source = "../modules/route53"
    cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
    cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  
}
