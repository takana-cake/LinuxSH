#!/bin/bash

#/dev/disk/by-id/*part1
#ここのやつを検知
#
#常設は例外リストに
#usb_mount_exception.list
#
#swatchかなんかで監視して実行？
#
#sambaのconfigは？あらかじめ書いとくで

#ls /dev/disk/by-id/ -l | sed -e "1d" | tr -s [:space:] | cut -d " " -f 9 >> ./usb_mount_exception.list
EXCEPTION=(`cat ./usb_mount_exception.list`)
LS=(`ls -l /dev/disk/by-id/ | sed -e "1d" | tr -s [:space:] | cut -d " " -f 9`)
for item in ${LS[@]}
do
	if echo ${EXCEPTION[@]} | grep -v $item >/dev/null; then
		BYID+=($item)
	fi
done
MNT=("h" "i" "j")
#SAMBA="
#[${MNT[i]}]
#path = /mnt/${MNT[i]}
#guest ok = no
#read only = no
#browseable = yes
#inherit acls = yes
#inherit permissions = no
#ea support = no
#store dos attributes = no
#vfs objects =
#printable = no
#create mask = 0660
#force create mode = 0660
#directory mask = 0770
#force directory mode = 0770
#hide special files = yes
#follow symlinks = yes
#hide dot files = yes
#valid users =
#invalid users =
#read list =
#write list =
#"

for((i=0; i<${#BYID[@]}; i++))
do
	DEV=`ls -l /dev/disk/by-id/${BYID[i]} | grep .*sd[a-z][0-9] | sed 's/..\/..\///g' | awk '{print $NF}'`
	FS=`lsblk -O | grep $DEV | tr -s [:space:] | cut -d " " -f 4`
	mount /dev/${DEV} /mnt/${MNT[i]} ${FS} default 0 0
	#echo "$SAMBA" 
done

