resource "aws_instance" "instance_tomcat" {
  ami = var.ami_id
  instance_type = var.ami_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  associate_public_ip_address = false
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    Name = "Tomcat"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      agent = false
      timeout = "40s"
      user = var.ssh_user
      host = aws_instance.instance_tomcat.public_dns
      private_key = tls_private_key.t.private_key_pem
    }
    inline = [
      "sudo yum -y install java-1.8.0-openjdk-devel",
      "cd /opt",
      "sudo wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.63/bin/apache-tomcat-8.5.63.tar.gz",
      "sudo tar -xvzf /opt/apache-tomcat-8.5.63.tar.gz",
      "sudo chmod +x /opt/apache-tomcat-8.5.63/bin/startup.sh",
      "sudo ln -s /opt/apache-tomcat-8.5.63/bin/startup.sh /usr/local/bin/tomcatup",
      "sudo ln -s /opt/apache-tomcat-8.5.63/bin/shutdown.sh /usr/local/bin/tomcatdown"
    ]
  }
}