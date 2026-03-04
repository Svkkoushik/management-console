resource "ibm_resource_instance" "cos-management-console" {
  name              = "cos-management-console"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = ibm_resource_group.rg-management-console.id
  tags              = local.tags

}
