resource "openstack_blockstorage_volume_v3" "volume_1" {
  availability_zone = "${openstack_compute_instance_v2.instance_5.availability_zone}"
  name        = "volume_1"
  description = "backupdisk_1"
  size        = 100
}

resource "openstack_blockstorage_volume_v3" "volume_2" {
  availability_zone = "${openstack_compute_instance_v2.instance_5.availability_zone}"
  name        = "volume_2"
  description = "backupdisk_2"
  size        = 100
}

resource "openstack_compute_volume_attach_v2" "attach_1" {
  instance_id = "${openstack_compute_instance_v2.instance_5.id}"
  volume_id   = "${openstack_blockstorage_volume_v3.volume_1.id}"
}

resource "openstack_compute_volume_attach_v2" "attach_2" {
  instance_id = "${openstack_compute_instance_v2.instance_5.id}"
  volume_id   = "${openstack_blockstorage_volume_v3.volume_2.id}"
}
