# Create Security Groups
resource "openstack_compute_secgroup_v2" "secgroup_1" {
  name                = "webSG"
  description         = "webserver SG for Port 80 and 443"

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
  description         = "SSH for Ansible configurations"

  rule {
    from_port         = 22
    to_port           = 22
    ip_protocol       = "tcp"
    cidr              = var.ANS_SG_IP
  }
}

resource "openstack_compute_secgroup_v2" "secgroup_3" {
  name                = "SSH"
  description         = "SSH from remote"

  rule {
    from_port         = 22
    to_port           = 22
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "secgroup_4" {
  name                = "MySQL"
  description         = "Port for MySQL"

  rule {
    from_port         = 3306
    to_port           = 3306
    ip_protocol       = "tcp"
    cidr              = var.WEB_SG_IP
  }
}

resource "openstack_compute_secgroup_v2" "secgroup_5" {
  name                = "jitsiSG"
  description         = "jitsi SG for Port 4443 and 10000 UDP"

  rule {
    from_port         = 4443
    to_port           = 4443
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 10000
    to_port           = 10000
    ip_protocol       = "udp"
    cidr              = "0.0.0.0/0"
  }
}
