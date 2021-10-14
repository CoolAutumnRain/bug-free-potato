## PROVIDER
# Configure the OpenStack Provider

# Allocate Floating IP
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool                = var.fip_pool
}

resource "openstack_networking_floatingip_v2" "floatip_2" {
  pool                = var.fip_pool
}

resource "openstack_networking_floatingip_v2" "floatip_3" {
  pool                = var.fip_pool
}


## INSTANCE
# Create an instance
resource "openstack_compute_instance_v2" "instance_1" {
  name                = var.webserver_instance
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["${openstack_compute_secgroup_v2.secgroup_1.name}","${openstack_compute_secgroup_v2.secgroup_2.name}"]
  user_data           = var.cloudconfig_web
  metadata            = {sw_webserver_nginx_http_port = "80", sw_webserver_nginx_https_port = "443", sw_webserver_nginx_version = "1.20.0"}
  availability_zone   = "sto3"

  network {
    port              = "${openstack_networking_port_v2.port_1.id}"
  }
}


resource "openstack_compute_instance_v2" "instance_2" {
  name                = var.ansible_instance
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["${openstack_compute_secgroup_v2.secgroup_3.name}"]
  user_data           = var.cloudconfig_ansible
  availability_zone   = "sto1"

  network {
    port              = "${openstack_networking_port_v2.port_2.id}"
  }

}

resource "openstack_compute_instance_v2" "instance_3" {
  name                = var.database_instance
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["${openstack_compute_secgroup_v2.secgroup_4.name}"]
  user_data           = var.cloudconfig_database
  availability_zone   = "sto1"

  network {
    port              = "${openstack_networking_port_v2.port_3.id}"
  }

}

resource "openstack_compute_instance_v2" "instance_4" {
  name                = var.jitsi_instance
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["${openstack_compute_secgroup_v2.secgroup_2.name}","${openstack_compute_secgroup_v2.secgroup_5.name}"]
  user_data           = var.cloudconfig_web
  availability_zone   = "sto3"

  network {
    port              = "${openstack_networking_port_v2.port_4.id}"
  }

}

resource "openstack_compute_instance_v2" "instance_5" {
  name                = var.backup_instance
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["${openstack_compute_secgroup_v2.secgroup_2.name}"]
  availability_zone   = "sto1"
  network {
    port              = "${openstack_networking_port_v2.port_5.id}"
  }

}

resource "openstack_compute_instance_v2" "instance_6" {
  name                = var.DC_instance
  image_name          = var.image_name_dc
  flavor_name         = var.flavor_name_dc
  key_pair            = var.key_name
  security_groups     = ["${openstack_compute_secgroup_v2.secgroup_6.name}"]
  availability_zone   = "sto1"

  network {
    port              = "${openstack_networking_port_v2.port_6.id}"
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

resource "openstack_networking_floatingip_associate_v2" "fip_3" {
  floating_ip         = "${openstack_networking_floatingip_v2.floatip_3.address}"
  port_id             = "${openstack_networking_port_v2.port_4.id}"
}
