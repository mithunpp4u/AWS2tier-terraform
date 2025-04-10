output "web_sg_id" {
  value= aws_security_group.webbsg.id
}

output "alb_sg_id" {
  value = aws_security_group.albsg.id
}

output "db_sg_id" {
  value = aws_security_group.dbsg.id
  
}