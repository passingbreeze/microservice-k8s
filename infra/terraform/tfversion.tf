terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "msgq-microservice-kube"
    key = "msgq/v1/kube.tfstate"
    region = "ap-northeast-2"   
    dynamodb_table = "msgq-msv-kube-table"
    encrypt = true 
  }
}