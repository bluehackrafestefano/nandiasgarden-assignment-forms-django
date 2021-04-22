terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-042e8287309f5df03" # Ubuntu 20 server, us-east-1
  instance_type = "t2.micro"
  key_name      = "rafeNvirginia"

  user_data = <<-EOF
      #!/bin/bash
      sudo apt update -y
      sudo apt upgrade -y
      sudo apt install python3-pip python3-dev libpq-dev nginx curl -y
      git clone https://github.com/bluehackrafestefano/nandiasgarden-assignment-forms-django.git
      chmod -R 755 nandiasgarden-assignment-forms-django
      sudo -H pip3 install virtualenv
      virtualenv env
      source env/bin/activate
      pip install django gunicorn psycopg2-binary pillow
      
      EOF

  tags = {
    Name = "NandiasGardenWebServer"
  }
}