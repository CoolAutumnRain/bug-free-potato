output "floating_ip_addresses" {
  value = ["${openstack_networking_floatingip_v2.floatip_1.address}","${openstack_networking_floatingip_v2.floatip_2.address}","${openstack_networking_floatingip_v2.floatip_3.address}"]
}
