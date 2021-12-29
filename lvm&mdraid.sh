!#/bin/bash

pvcreate sda, sdc
vgcreate vg_1 /sda /sdc
lvcreate -l 100%FREE -n lv_1 vg_1
mkfs && mount

mdadm --create -v /dev/md0 --level=1 --raid-device=2 /dev/sde /dev/sdd
mkfs && mount
