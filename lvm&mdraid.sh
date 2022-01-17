!#/bin/bash

pvcreate sda, sdc
vgcreate vg_1 /sda /sdc
lvcreate -l 100%FREE -n lv_1 vg_1
mkfs.ext4 /dev/vg_1/lv_1
mount /dev/vg_1/lv_1 /local/files

mdadm --create -v /dev/md0 --level=1 --raid-device=2 /dev/sde /dev/sdd
mkfs.ext4 /dev/md0
mount /dev/md0 /local/backups
