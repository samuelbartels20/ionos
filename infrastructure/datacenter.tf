resource "ionoscloud_datacenter" "k8s-datacenter" {
  name        = var.datacenter_name
  location    = var.datacenter_location
  description = "Production Kubernetes infrastructure for ${var.project_name}"

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

resource "ionoscloud_lan" "k8s-public-lan" {
  datacenter_id = ionoscloud_datacenter.k8s-datacenter.id
  public        = true
  name          = "public-lan"

  depends_on = [ionoscloud_datacenter.k8s-datacenter]
}

# Private LAN for internal communication
resource "ionoscloud_lan" "k8s-private-lan" {
  datacenter_id = ionoscloud_datacenter.k8s-datacenter.id
  public        = false
  name          = "private-lan"

  depends_on = [ionoscloud_datacenter.k8s-datacenter]
}

resource "ionoscloud_ipblock" "k8s-ipblock" {
  location   = var.datacenter_location
  size       = var.ipblock_size
  name       = "ipblock"
  depends_on = [ionoscloud_datacenter.k8s-datacenter]
}
