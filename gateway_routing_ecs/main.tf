terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  backend "local" {
    path = "state/terraform.tfstate"
  }
}

provider "aws" {
  region     = var.provider_aws_region
  access_key = var.provider_aws_access_key
  secret_key = var.provider_aws_secret_key

  default_tags {
    tags = {
      Environment = "estudos-gateway-routing"
      Name        = "estudos-gateway-routing"
    }
  }
}

module "vpc" {
  source = "./vpc"
}

module "igtw" {
  source     = "./internet-gateway"
  vpc_id     = module.vpc.vpc_id
  depends_on = [module.vpc]
}

module "nat" {
  source     = "./nat"
  subnet_1   = module.vpc.pub_subnet_01
  subnet_2   = module.vpc.pub_subnet_02
  depends_on = [module.vpc]
}

module "sg" {
  source     = "./security-group"
  vpc_id     = module.vpc.vpc_id
  cidr_block = module.vpc.vpc_cidr_block
  depends_on = [module.vpc]
}

module "route_table" {
  source          = "./route-table"
  igtw_id         = module.igtw.id
  vpc_id          = module.vpc.vpc_id
  subnet_id_pub_1 = module.vpc.pub_subnet_01
  subnet_id_pub_2 = module.vpc.pub_subnet_02
  subnet_id_pri_1 = module.vpc.pri_subnet_01
  subnet_id_pri_2 = module.vpc.pri_subnet_02
  nat_id_1        = module.nat.id_1
  nat_id_2        = module.nat.id_2
  depends_on      = [module.vpc, module.igtw]
}

module "ecs" {
  source                  = "./ecs"
  security_group_pub_id   = module.sg.pub_id
  security_group_pri_id   = module.sg.pri_id
  vpc_id                  = module.vpc.vpc_id
  subnet_id_pub_1         = module.vpc.pub_subnet_01
  subnet_id_pub_2         = module.vpc.pub_subnet_02
  subnet_id_pri_1         = module.vpc.pri_subnet_01
  subnet_id_pri_2         = module.vpc.pri_subnet_02
  depends_on              = [module.vpc, module.sg]
  provider_aws_access_key = var.provider_aws_access_key
  provider_aws_secret_key = var.provider_aws_secret_key
  provider_aws_region     = var.provider_aws_region
  docker_hub_credentials  = var.docker_hub_credentials
}


module "parameter_storage" {
  source = "./parameter-storage"
  params = [
    {
      name  = "app-01",
      type  = "String"
      value = "Aplicação 01"
    },
    {
      name  = "app-02",
      type  = "String"
      value = "Aplicação 02"
    }
  ]
}

