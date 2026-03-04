
resource "ibm_database" "pg-management-console" {
  name              = "pg-management-console"
  plan              = "standard"
  location          = "eu-de"
  service           = "databases-for-postgresql"
  resource_group_id = ibm_resource_group.rg-management-console.id
  tags              = local.tags

  group {
    group_id = "member"

    memory {
      allocation_mb = 4096
    }

    disk {
      allocation_mb = 10240
    }

    cpu {
      allocation_count = 0
    }
  }

}
