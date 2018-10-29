#!/bin/sh

#/dev/disk/by-id/*part1
#ここのやつを検知
#
#常設は例外リストに
#usb_mount_exception.list
#
#swatchかなんかで監視して実行？


EXCEPTION=`cat /root/script/usb_mount_exception.list`
BYID=`diff <($EXCEPTION) <(ls /dev/disk/by-id/ -l | sed -e "1d" | tr -s [:space:] | cut -d " " -f 9) | grep ^\> | cut -d " " -f 2`
DEV=`ls -l /dev/disk/by-id/$BYID | grep .*sd[a-z][0-9] | sed 's/..\/..\///g' | awk '{print $NF}'`
FS=`lsblk -O | grep $DEV | tr -s [:space:] | cut -d " " -f 4`

echo "/dev/${DEV} /mnt/${MNT} ${FS} default 0 0" >> /etc/fstab
mount -a
