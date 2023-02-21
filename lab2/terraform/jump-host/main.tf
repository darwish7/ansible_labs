resource "aws_security_group" "proxy-sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

 
  # ingress {
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
module "ami" {
  source = "../ami"
}


resource "aws_instance" "jump-host" {
  ami = module.ami.ubuntu_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  associate_public_ip_address = "true"
  vpc_security_group_ids = [ aws_security_group.proxy-sg.id ]
  tags = {
    Name = var.public_ec2_name
  }
  key_name = "lab3.pem"
}