resource "aws_instance" "test-server" {
  ami           = "ami-03238ca76a3266a07" 
  instance_type = "t3.micro" 
  key_name = "KEY-AWS"
  vpc_security_group_ids= ["sg-05704caffd6a22988"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./KEY-AWS.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/insurance-app/akshay/insurance-playbook.yml "
  } 
}
