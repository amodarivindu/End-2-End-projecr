terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  count         = 2   # 🔥 multiple EC2s
  ami           = "ami-098e39bafa7e7303d"
  instance_type = "t2.micro"

  tags = {
    Name = "AppServer-${count.index}"
  }
}