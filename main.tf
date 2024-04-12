terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.54.1"
    }
  }
}

provider "openstack" {
  //auth_url    = "https://192.168.1.20:5000/v3/"
  //region      = "RegionOne"
  //cacert_file = "./microstack.download.crt"
}

resource "openstack_compute_instance_v2" "terraform-instance-1" {
  name = "terraform-instance-1"
  image_name = "ubuntu"
  flavor_name = "m1.core"
  security_groups = ["default"]
  key_pair = "microstack"
  network {
    name = "test"
  } 
}

resource "openstack_compute_instance_v2" "terraform-instance-2" {
  name = "terraform-instance-2"
  image_name = "ubuntu"
  flavor_name = "m1.core"
  security_groups = ["default"]
  key_pair = "microstack"
  network {
    name = "test"
  } 
  depends_on = [ openstack_compute_instance_v2.terraform-instance-1 ]
}

output "instance-1-ip" {
  description = "instance-1 ipaddress"
  value = openstack_compute_instance_v2.terraform-instance-1.access_ip_v4
}
output "instance-2-ip" {
  description = "instance-2 ipaddress"
  value = openstack_compute_instance_v2.terraform-instance-2.access_ip_v4
}