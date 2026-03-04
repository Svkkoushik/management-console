resource "ibm_resource_instance" "ai-management-console" {
  name              = "ai-management-console"
  service           = "appid"
  plan              = "graduated-tier"
  location          = local.region
  resource_group_id = ibm_resource_group.rg-management-console.id
  tags              = local.tags

}

resource "ibm_appid_idp_cloud_directory" "ai-idp-cloud-directory" {
  tenant_id = ibm_resource_instance.ai-management-console.guid
  is_active = true
  identity_confirm_methods = [
    "email"
  ]
  identity_field                      = "email"
  self_service_enabled                = false
  signup_enabled                      = false
  welcome_enabled                     = true
  reset_password_enabled              = false
  reset_password_notification_enabled = false
}

resource "ibm_appid_idp_facebook" "ai-idp-facebook" {
  tenant_id = ibm_resource_instance.ai-management-console.guid
  is_active = false

}

resource "ibm_appid_idp_google" "ai-idp-google" {
  tenant_id = ibm_resource_instance.ai-management-console.guid
  is_active = false
}
