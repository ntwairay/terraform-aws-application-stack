provider "aws" {
  version = "~> 2.11.0"
  region  = "ap-southeast-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = var.compute.app.instance_type

  tags = {
    Name = var.compute.app.tag_name
    appid = var.app_id
  }
}


resource "aws_instance" "worker" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = var.compute.worker.instance_type

  tags = {
    Name = var.compute.worker.tag_name
    appid = var.app_id
  }
}
