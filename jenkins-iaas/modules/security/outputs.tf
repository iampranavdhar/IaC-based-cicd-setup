output "jenkins_sg_id" {
  description = "The ID of the security group"
  value       = aws_security_group.jenkins_sg.id
}