## PROVIDER
# Configure the OpenStack Provider

## NETWORK
# Create network
resource "openstack_networking_network_v2" "network_1" {
  name                = var.network_name
  admin_state_up      = "true"
}

# Create subnet
resource "openstack_networking_subnet_v2" "subnet_1" {
  name                = var.subnet_IT
  network_id          = "${openstack_networking_network_v2.network_1.id}"
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
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  cidr                = var.HRFIN_cidr
  ip_version          = 4
  dns_nameservers     = var.dns_ip
}

resource "openstack_networking_subnet_v2" "subnet_4" {
  name                = var.subnet_RND
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  cidr                = var.RND_cidr
  ip_version          = 4
  dns_nameservers     = var.dns_ip
}

# Create Security Groups
resource "openstack_compute_secgroup_v2" "secgroup_1" {
  name                = "TerraformSG"
  description         = "Terraform SG for Port 80 and 443"

  rule {
    from_port         = 80
    to_port           = 80
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 443
    to_port           = 443
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "secgroup_2" {
  name                = "AnsibleSSH"
  description         = "Terraform SSH for Port 22"

  rule {
    from_port         = 22
    to_port           = 22
    ip_protocol       = "tcp"
    cidr              = "192.168.1.5/32"
  }
}

resource "openstack_compute_secgroup_v2" "secgroup_3" {
  name                = "TerraformSSH"
  description         = "Terraform SSH for Port 22"

  rule {
    from_port         = 22
    to_port           = 22
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }
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
 # security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_1.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_2.id}"
  # ip_address        =  
  }
}

resource "openstack_networking_port_v2" "port_2" {
  name                = "port_2"
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  admin_state_up      = "true"
 # security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_2.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_1.id}"
    ip_address        = var.ANS_ip  
  }
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


# Allocate Floating IP
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool                = var.fip_pool
}

resource "openstack_networking_floatingip_v2" "floatip_2" {
  pool                = var.fip_pool
}

## INSTANCE
# Create an instance
resource "openstack_compute_instance_v2" "instance_1" {
  name                = var.webserver_instance
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["default","${openstack_compute_secgroup_v2.secgroup_1.name}","${openstack_compute_secgroup_v2.secgroup_2.name}"]
  user_data           = var.cloudconfig_web
  metadata            = {sw_webserver_nginx_http_port = "80", sw_webserver_nginx_https_port = "443", sw_webserver_nginx_version = "1.20.0"}

  network {
    port              = "${openstack_networking_port_v2.port_1.id}"
  }
}


resource "openstack_compute_instance_v2" "instance_2" {
  name                = var.ansible_instance
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["default","${openstack_compute_secgroup_v2.secgroup_3.name}"]
  user_data           = var.cloudconfig_ansible

  network {
    port              = "${openstack_networking_port_v2.port_2.id}"
  }

}

# Associate Floating IP

resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip         = "${openstack_networking_floatingip_v2.floatip_2.address}"
  port_id             = "${openstack_networking_port_v2.port_1.id}"
}


resource "openstack_networking_floatingip_associate_v2" "fip_2" {
  floating_ip         = "${openstack_networking_floatingip_v2.floatip_1.address}"
  port_id             = "${openstack_networking_port_v2.port_2.id}"
}
