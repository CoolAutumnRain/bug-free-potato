## VARIABLES
# Make changes here

variable "webserver_instance" {
  type    = string
  default = "tf-web"
}

variable "ansible_instance" {
  type    = string
  default = "tf-ansible"
}

variable "database_instance" {
  type    = string
  default = "tf-db"
}

variable "jitsi_instance" {
  type    = string
  default = "tf-jitsi"
}

variable "backup_instance" {
  type    = string
  default = "tf-backup"
}

variable "ssh_group" {
  type    = string
  default = "TerraformSSH"
}

variable "web_group" {
  type    = string
  default = "TerraformWebGroup"
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

variable "subnet_DMZ" {
  type    = string
  default = "dmz_subnet"
}

variable "subnet_IT" {
  type    = string
  default = "IT_subnet"
}

variable "subnet_RND" {
  type    = string
  default = "RND_subnet"
}

variable "subnet_HRFIN" {
  type    = string
  default = "HRFIN_subnet"
}

variable "IT_cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "RND_cidr" {
  type    = string
  default = "192.168.3.0/24"
}

variable "DMZ_cidr" {
  type    = string
  default = "192.168.2.0/24"
}

variable "HRFIN_cidr" {
  type    = string
  default = "192.168.5.0/24"
}

variable "dns_ip" {
  type    = list(string)
  default = [ "8.8.8.8", "8.8.4.4" ]
}

variable "ANS_ip" {
  type    = string
  default = "192.168.1.5"
}

variable "WEB_ip" {
  type    = string
  default = "192.168.2.5"
}

variable "WEB_SG_IP" {
  type    = string
  default = "192.168.2.5/32"
}

variable "ANS_SG_IP" {
  type    = string
  default = "192.168.1.5/32"
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
    name: webserver
packages:
 - nginx
EOF
}

variable "cloudconfig_ansible" {
  type    = string
  default = <<EOF
#cloud-config
system_info:
  default_user:
    name: ansible
packages:
 - ansible
EOF
}

variable "cloudconfig_database" {
  type    = string
  default = <<EOF
#cloud-config
system_info:
  default_user:
    name: database
packages:
 - mysql
EOF
}
