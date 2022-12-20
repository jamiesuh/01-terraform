terraform {
  # 테라폼 버전 지정
  required_version = ">=1.0.0, < 2.0.0"

  # 공급자 버전 지정
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-06eea3cd85e2db8ce"  # ubuntu 20.04 version
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  key_name = "aws13-key"

  user_data = <<-EOF
		  #!/bin/bash
		  echo "Hello, World" > index.html
		  nohup busybox httpd -f -p ${var.server_port} &
		  EOF
  # tag 추가 
  tags = {
    Name = "aws13-terraform-example"
  }

}

# 보안 그룹 생성
resource "aws_security_group" "instance" {
  name = "aws13-terraform-example-instance"

# 인바운드 규칙 설정
  ingress {
    from_port   = var.server.port # 출발포트
    to_port     = var.server.port # 도착포트
    protocol    = "tcp" # 프로토콜
    cidr_blocks = ["0.0.0.0/0"]  # 송신지 

  }
}


# Public IP Output 
output "public-ip" {
  value       = aws_instance.example.public_ip
  description = "The Public IP of the Instance"

}
