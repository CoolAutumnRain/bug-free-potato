## VARIABLES
# Make changes here

variable "instance_name" {
  type    = string
  default = "tf-web"
}

variable "instance_name2" {
  type    = string
  default = "jitsihost"
}

variable "image_name" {
  type    = string
  default = "ubuntu-20.04-server-latest"
}

variable "flavor_name" {
  type    = string
  default = "v1-mini-1"
}

variable "key_name" {
  type    = string
  default = "caelum"
}

variable "network_name" {
  type    = string
  default = "network1"
}

variable "subnet_name" {
  type    = string
  default = "tf_subnet_1"
}

variable "subnet_cidr" {
  type    = string
  default = "192.168.199.0/24"
}

variable "dns_ip" {
  type    = list(string)
  default = [ "8.8.8.8", "8.8.4.4" ]
}

variable "port_ip" {
  type    = string
  default = "192.168.199.10"
}

variable "port_ip2" {
  type    = string
  default = "192.168.199.11"
}

variable "external_network" {
 default = "elx-public1"
}

variable "external_network_id" {
  type = map
  default = {
    "elx-public1" = "600b8501-78cb-4155-9c9f-23dfcba88828",
  }
}

variable "router_name" {
  type    = string
  default = "router1"
}

variable "router_id" {
  type    = string
  default = "12b0c774-ab51-40d8-ba27-fdb5040839ee"
}

variable "fip_pool" {
  type    = string
  default = "elx-public1"
}

variable "region" {
  type    = string
  default = "sto1"
}

variable "cloudconfig_web" {
  type    = string
  default = <<EOF
#cloud-config
system_info:
  default_user:
    name: cloudman
packages:
 - openstack swift
EOF
}

variable "cloudconfig_jitsi" {
  type    = string
  default = <<EOF
#cloud-config
system_info:
  default_user:
    name: jitsiman
packages:
EOF
}
