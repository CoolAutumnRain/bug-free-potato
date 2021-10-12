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
  name                = var.subnet_name
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  cidr                = var.subnet_cidr
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
  name                = "TerraformSSH"
  description         = "Terraform SH for Port 22"

  rule {
    from_port         = 22
    to_port           = 22
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0" # only for demo purposes, tighten up in live scenario
  }
}

resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  external_network_id = lookup(var.external_network_id, var.external_network)
}

# Create a port
resource "openstack_networking_port_v2" "port_1" {
  name                = "port_1"
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  admin_state_up      = "true"
  security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_1.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_1.id}"
    ip_address        = var.port_ip
  }
}

#Creates another port
resource "openstack_networking_port_v2" "port_2" {
  name                = "port_2"
  network_id          = "${openstack_networking_network_v2.network_1.id}"
  admin_state_up      = "true"
  security_group_ids  = ["${openstack_compute_secgroup_v2.secgroup_1.id}"]

  fixed_ip {
    subnet_id         = "${openstack_networking_subnet_v2.subnet_1.id}"
    ip_address        = var.port_ip2
  }
}

# Connect the subnet to the router
resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id           = "${openstack_networking_router_v2.router.id}"
  subnet_id           = "${openstack_networking_subnet_v2.subnet_1.id}"
}

# Allocate Floating IP
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool                = var.fip_pool
}

# Allocate floating ip 2
resource "openstack_networking_floatingip_v2" "floatip_2" {
 pool                 = var.fip_pool
}

## INSTANCE
# Create an instance
resource "openstack_compute_instance_v2" "instance_1" {
  name                = var.instance_name
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["default","${openstack_compute_secgroup_v2.secgroup_1.name}","${openstack_compute_secgroup_v2.secgroup_2.name}"]
  user_data           = var.cloudconfig_web

  network {
    port              = "${openstack_networking_port_v2.port_1.id}"
  }
}

# Associate Floating IP
resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip         = "${openstack_networking_floatingip_v2.floatip_1.address}"
  port_id             = "${openstack_networking_port_v2.port_1.id}"
}


# Associate Floating ip 2
resource "openstack_networking_floatingip_associate_v2" "fip_2" {
  floating_ip         = "${openstack_networking_floatingip_v2.floatip_2.address}"
  port_id             = "${openstack_networking_port_v2.port_2.id}"
}


## INSTANCE
# Creates another instance
resource "openstack_compute_instance_v2" "instance_2" {
  name                = var.instance_name2
  image_name          = var.image_name
  flavor_name         = var.flavor_name
  key_pair            = var.key_name
  security_groups     = ["default","${openstack_compute_secgroup_v2.secgroup_1.name}","${openstack_compute_secgroup_v2.secgroup_2.name}"]
  user_data           = var.cloudconfig_jitsi

#  network {
#    port              = "${openstack_networking_port_v2.port_2.id}"
#  }
#  provisioner "remote-exec" {
#    inline = [
#  "sudo touch here",
#  "sudo apt update -y",
#  "sudo apt upgrade -y",
#  "sudo apt install apt-transport-https -y",
#  "sudo apt-add-repository universe -y",
#  "sudo apt install openjdk-11-jdk -y",
#  "sudo apt update -y",
#  "sudo apt clean -y",
#  "sudo echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list",
#  "sudo wget https://prosody.im/files/prosody-debian-packages.key -O- | sudo apt-key add -",
#  "sudo curl https://download.jitsi.org/jitsi-key.gpg.key | sudo sh -c 'gpg --dearmor > /usr/share/keyrings/jitsi-keyring.gpg'",
#  "sudo echo 'deb [signed-by=/usr/share/keyrings/jitsi-keyring.gpg] https://download.jitsi.org stable/' | sudo tee /etc/apt/sources.list.d/jitsi-stable.list > /dev/null",
#  "sudo apt update -y",
#  "sudo apt install jitsi-meet -y",
#    ]
#  }

  connection {
    host      = "${openstack_networking_floatingip_v2.floatip_2.address}"
    type      = "ssh"
    user      = "jitsiman"
    password  = ""
    private_key= "${file("~/id_rsa")}"
  }
}

resource "openstack_blockstorage_volume_v3" "volume_1" {
  availability_zone = "sto1"
  name        = "volume_1"
  description = "Cloudstorage"
  size        = 10
}

resource "openstack_blockstorage_volume_v3" "volume_1_backup" {
  availability_zone = "sto2"
  name        = "volume_1_backup"
  description = "Cloudstorage_backup"
  size        = 10
}
