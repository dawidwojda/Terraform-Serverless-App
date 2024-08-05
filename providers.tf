terraform {
    required_version = "~> 1.9.3"
    
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    backend "s3" {
        bucket = "state-bucket-dw"
        key = "terraform.tfstate"
        region = "eu-central-1"
        dynamodb_table = "state-table-dw"
    }
}

provider "aws" {
    region = "eu-central-1"
}
