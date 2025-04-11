output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "internet_gw_id" {
    value = aws_internet_gateway.my_gw1.id 
}

output "pb_sub1_id" {
  value = aws_subnet.mypsub1.id
}
output "pb_sub2_id" {
  value = aws_subnet.mypsub2.id
}
output "pr_sub1_id" {
    value = aws_subnet.myprv1.id 
}
output "pr_sub2_id" {
  value = aws_subnet.myprv2.id
}
output "pr_sub3_id" {
  value = aws_subnet.myprv3.id
}
output "pr_sub4_id" {
  value = aws_subnet.myprv4.id
}
