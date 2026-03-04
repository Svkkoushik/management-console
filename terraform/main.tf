
terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.67.1"
    }
  }
  cloud {
    organization = "ndbs-innovation"
    workspaces {
      name = "management-console"
    }
  }
}

provider "ibm" {
  region           = "eu-de"
  ibmcloud_api_key = var.IBM_IAM_API_KEY
}

resource "ibm_resource_group" "rg-management-console" {
  name = "rg-management-console"
  tags = local.tags
}
