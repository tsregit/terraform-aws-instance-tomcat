output "server-ip" {
  value = aws_instance.instance_tomcat.public_ip
}