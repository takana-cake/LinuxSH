#!/bin/bash

#/dev/disk/by-id/*part1
#ここのやつを検知
#
#常設は例外リストに
#usb_mount_exception.list
#
#swatchかなんかで監視して実行？

#ls /dev/disk/by-id/ -l | sed -e "1d" | tr -s [:space:] | cut -d " " -f 9 >> ./usb_mount_exception.list
EXCEPTION=`cat ./usb_mount_exception.list`

BYID=(`diff <($EXCEPTION) <(ls /dev/disk/by-id/ -l | sed -e "1d" | tr -s [:space:] | cut -d " " -f 9) | grep ^\> | cut -d " " -f 2 | tr "\n" " "`)
for item in ${BYID[@]}; do
	DEV=(`ls -l /dev/disk/by-id/$item | grep .*sd[a-z][0-9] | sed 's/..\/..\///g' | awk '{print $NF}'`)
	FS=`lsblk -O | grep $DEV | tr -s [:space:] | cut -d " " -f 4`
	echo "/dev/${DEV} /mnt/${MNT} ${FS} default 0 0" >> /etc/fstab
done

#https://qiita.com/exy81/items/723184c0fcd7953d0f2c
#for((i=0; i<${BYID[@]}; i++))
#do
#	DEV+=(`ls -l /dev/disk/by-id/$BYID[i] | grep .*sd[a-z][0-9] | sed 's/..\/..\///g' | awk '{print $NF}'`)
#	FS=`lsblk -O | grep $DEV[i] | tr -s [:space:] | cut -d " " -f 4`
#done
mount -a
