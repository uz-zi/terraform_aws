//https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "web" {
  ami             = "ami-042b4708b1d05f512"
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "first-tf-instance"
  }
}

//aws key apir
//https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  //https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
  dynamic "ingress" {
    for_each = [22, 80, 443]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

	egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
  }
}


output "keyname" {
  value = aws_key_pair.key-tf.key_name
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic and all outbound traffic"

#   //https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
#   dynamic "ingress" {
#     for_each = [22, 80, 443, 3306, 27017]
#     iterator = port
#     content {
#       description = "TLS from VPC"
#       from_port   = port.value
#       to_port     = port.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
# }



