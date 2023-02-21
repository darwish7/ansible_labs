resource "aws_security_group" "private-sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

 
 ingress {
    description      = "SSH from Anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.source-cidr-blocks]
    ipv6_cidr_blocks = [var.source-cidr-blocks-ipv6]
  }

    ingress {
    description      = "SSH from Anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.source-cidr-blocks]
    ipv6_cidr_blocks = [var.source-cidr-blocks-ipv6]
  }

  ingress {
    description      = "HTTP from Anywhere"
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = [var.source-cidr-blocks]
    ipv6_cidr_blocks = [var.source-cidr-blocks-ipv6]
  }

    ingress {
    description      = "HTTP from Anywhere"
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    cidr_blocks      = [var.source-cidr-blocks]
    ipv6_cidr_blocks = [var.source-cidr-blocks-ipv6]
  }

      ingress {
    description      = "HTTP from Anywhere"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [var.source-cidr-blocks]
    ipv6_cidr_blocks = [var.source-cidr-blocks-ipv6]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.source-cidr-blocks]
    ipv6_cidr_blocks = [var.source-cidr-blocks-ipv6]
  }

  
}
module "ami" {
  source = "../ami"
}

resource "aws_instance" "private_ec2" {
  instance_type = var.instance_type
  count = length(var.subnet_ids)
  subnet_id     = var.subnet_ids[count.index]
  ami = [module.ami.amazon_linux_id,module.ami.ubuntu_id][count.index]
  vpc_security_group_ids = [ aws_security_group.private-sg.id ]
  tags = {
    Name = var.private_ec2_name
  }
  key_name = "lab3.pem"
}