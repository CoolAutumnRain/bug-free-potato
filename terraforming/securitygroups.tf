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


resource "openstack_compute_secgroup_v2" "secgroup_6" {
  name                = "winADSG"
  description         = "Opens ports as requiered for winAD"

  rule {
    from_port         = 123
    to_port           = 123
    ip_protocol       = "udp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 135
    to_port           = 135
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 464
    to_port           = 464
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 464
    to_port           = 464
    ip_protocol       = "udp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 49152
    to_port           = 65535
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 389
    to_port           = 389
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 389
    to_port           = 389
    ip_protocol       = "udp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 636
    to_port           = 636
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 3268
    to_port           = 3269
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 53
    to_port           = 53
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 53
    to_port           = 53
    ip_protocol       = "udp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 49152
    to_port           = 65535
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 88
    to_port           = 88
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 88
    to_port           = 88
    ip_protocol       = "udp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 445
    to_port           = 445
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

  rule {
    from_port         = 49152
    to_port           = 65535
    ip_protocol       = "tcp"
    cidr              = "0.0.0.0/0"
  }

}
