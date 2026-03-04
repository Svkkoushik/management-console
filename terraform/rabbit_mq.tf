
# NOTE: It is possible this should be an `ibm_database` resource instead of an `ibm_resource_instance` resource
resource "ibm_resource_instance" "rmq-management-console" {
  name              = "rmq-management-console"
  service           = "messages-for-rabbitmq"
  resource_group_id = ibm_resource_group.rg-management-console.id
  tags              = local.tags

  plan     = "standard"
  location = local.region
}
