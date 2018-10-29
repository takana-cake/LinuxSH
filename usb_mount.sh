#!/bin/sh

/dev/disk/by-id/*part1
ここのやつを検知

常設は例外リストに
usb_mount_exception.list



ID=`diff <(cat /root/script/usb_mount_exception.list) <(ls /dev/disk/by-id/ -l | sed -e "1d" | tr -s [:space:] | cut -d " " -f 9) | grep ^\> | cut -d " " -f 2`
DEV=`ls -l /dev/disk/by-id/$ID | sed 's/..\/..\///g' | awk '{print $NF}'`
FS=`lsblk -O | grep $DEV | tr -s [:space:] | cut -d " " -f 4`


