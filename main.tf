terraform {
  cloud {
    organization = "VuongDQ-Organization"

    workspaces {
      name = "vuongdq-terraform-series-remote-backend"
    }
  }
}

provider "aws" {
    region = var.region
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "server" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Server"
  }
}