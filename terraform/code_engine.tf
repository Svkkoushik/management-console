
resource "ibm_code_engine_project" "ce-management-console" {
  name              = "ce-management-console"
  resource_group_id = ibm_resource_group.rg-management-console.id
}


resource "ibm_cr_namespace" "ns-management-console" {
  name = "ns-management-console"

  resource_group_id = ibm_resource_group.rg-management-console.id

  tags = local.tags
}


resource "ibm_code_engine_app" "ingestion-service" {
  project_id      = ibm_code_engine_project.ce-management-console.id
  name            = "ingestion-service"
  image_reference = "private.de.icr.io/${ibm_cr_namespace.ns-management-console.name}/backend:${var.git_sha}"
  # this is some special auto-generated secret TODO: investigate if there is a better way than hardcoding this
  image_secret = "ce-auto-icr-private-eu-de"

  image_port = 8000


  run_env_variables {
    name  = "CE_API_BASE_URL"
    value = "https://api.eu-de.codeengine.cloud.ibm.com"
  }

  run_env_variables {
    name  = "CE_REGION"
    type  = "literal"
    value = local.region
  }

  run_env_variables {
    name  = "CE_PROJECT_ID"
    type  = "literal"
    value = ibm_code_engine_project.ce-management-console.id
  }

  run_env_variables {
    name  = "CE_APP"
    type  = "literal"
    value = "ingestion-service"
  }

  run_env_variables {
    name  = "CE_DOMAIN"
    type  = "literal"
    value = "eu-de.codeengine.appdomain.cloud"
  }

  run_env_variables {
    name  = "CE_SUBDOMAIN"
    type  = "literal"
    value = "1iyzh3j4uer6"
  }


}

resource "ibm_code_engine_app" "webapp" {
  project_id      = ibm_code_engine_project.ce-management-console.id
  name            = "webapp"
  image_reference = "private.de.icr.io/${ibm_cr_namespace.ns-management-console.name}/webapp:${var.git_sha}"
  # this is some special auto-generated secret TODO: investigate if there is a better way than hardcoding this
  image_secret = "ce-auto-icr-private-eu-de"

  image_port = 3000

  run_env_variables {
    name  = "CE_API_BASE_URL"
    value = "https://api.eu-de.codeengine.cloud.ibm.com"
  }

  run_env_variables {
    name  = "CE_REGION"
    type  = "literal"
    value = local.region
  }

  run_env_variables {
    name  = "CE_PROJECT_ID"
    type  = "literal"
    value = ibm_code_engine_project.ce-management-console.id
  }

  run_env_variables {
    name  = "CE_APP"
    type  = "literal"
    value = "ingestion-service"
  }

  run_env_variables {
    name  = "CE_DOMAIN"
    type  = "literal"
    value = "eu-de.codeengine.appdomain.cloud"
  }

  run_env_variables {
    name  = "CE_SUBDOMAIN"
    type  = "literal"
    value = "1iyzh3j4uer6"
  }


}
