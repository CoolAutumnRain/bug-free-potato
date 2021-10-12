## NETWORK
# Create network
resource "openstack_networking_network_v2" "network_1" {
  name                = "DMZ"
  admin_state_up      = "true"
}

resource "openstack_networking_network_v2" "network_2" {
  name                = "INTRANET"
  admin_state_up      = "true"
}


resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  external_network_id = lookup(var.external_network_id, var.external_network)
}

# Create ports
resource "openstack_networking_port_v2" "port_1" {
  name                = "port_1"
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  admin_state_up      = "true"
  security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_1.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_2.id}"
    ip_address        = var.WEB_ip
  }
}

resource "openstack_networking_port_v2" "port_2" {
  name                = "port_2"
  network_id          = "${openstack_networking_network_v2.network_2.id}"
  admin_state_up      = "true"
  security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_3.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_1.id}"
    ip_address        = var.ANS_ip
  }
}

resource "openstack_networking_port_v2" "port_3" {
  name                = "port_3"
  network_id          = "${openstack_networking_network_v2.network_2.id}"
  admin_state_up      = "true"
  security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_4.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_1.id}"
  # ip_address        = 
  }
}

resource "openstack_networking_port_v2" "port_4" {
  name                = "port_4"
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  admin_state_up      = "true"
  security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_5.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_2.id}"
  # ip_address        =
  }
}

resource "openstack_networking_port_v2" "port_5" {
  name                = "port_5"
  network_id          = "${openstack_networking_network_v2.network_2.id}"
  admin_state_up      = "true"
  security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_1.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_1.id}"
    #id_address       =
  }
}

resource "openstack_networking_port_v2" "port_6" {
  name                = "port_6"
  network_id          = "${openstack_networking_network_v2.network_2.id}"
  admin_state_up      = "true"
  security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_6.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_1.id}"
    #id_address       =
  }
}

# Create subnet
resource "openstack_networking_subnet_v2" "subnet_1" {
  name                = var.subnet_IT
  network_id          = "${openstack_networking_network_v2.network_2.id}"
  cidr                = var.IT_cidr
  ip_version          = 4
  dns_nameservers     = var.dns_ip
}

resource "openstack_networking_subnet_v2" "subnet_2" {
  name                = var.subnet_DMZ
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  cidr                = var.DMZ_cidr
  ip_version          = 4
  dns_nameservers     = var.dns_ip
}

resource "openstack_networking_subnet_v2" "subnet_3" {
  name                = var.subnet_HRFIN
  network_id          = "${openstack_networking_network_v2.network_2.id}"
  cidr                = var.HRFIN_cidr
  ip_version          = 4
  dns_nameservers     = var.dns_ip
}

resource "openstack_networking_subnet_v2" "subnet_4" {
  name                = var.subnet_RND
  network_id          = "${openstack_networking_network_v2.network_2.id}"
  cidr                = var.RND_cidr
  ip_version          = 4
  dns_nameservers     = var.dns_ip
}

# Connect the subnet to the router
resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id           = "${openstack_networking_router_v2.router.id}"
  subnet_id           = "${openstack_networking_subnet_v2.subnet_1.id}"
}

resource "openstack_networking_router_interface_v2" "router_interface_2" {
  router_id           = "${openstack_networking_router_v2.router.id}"
  subnet_id           = "${openstack_networking_subnet_v2.subnet_2.id}"
}

