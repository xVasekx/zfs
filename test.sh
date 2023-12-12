#!/bin/bash 
#install zfs repo
yum install -y http://download.zfsonlinux.org/epel/zfs-release.el7_8.noarch.rpm
#import gpg key 
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinux
#install DKMS style packages for correct work ZFS
yum install -y epel-release kernel-devel zfs
#change ZFS repo
yum-config-manager --disable zfs
yum-config-manager --enable zfs-kmod
yum install -y zfs
#Add kernel module zfs
modprobe zfs
#install wget
yum install -y wget
#Add pool RAID1
zpool create test1 mirror /dev/sdb /dev/sdc
zpool create test2 mirror /dev/sdd /dev/sde
zpool create test3 mirror /dev/sdf /dev/sdg
zpool create test4 mirror /dev/sdh /dev/sdi
#Add compression zfs
zfs set compression=lzjb test1
zfs set compression=lz4 test2
zfs set compression=gzip-9 test3
zfs set compression=zle test4
#Download file
wget https://gutenberg.org/cache/epub/2600/pg2600.converter.log;
#Copy file to pool zfs
for i in {1..4}; do cp -rf ./pg2600.converter.log /test$i;  done
#Download archive to home
wget -O archive.tar.gz --no-check-certificate 'https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download'
#Unpack archive
tar -xzvf archive.tar.gz
#Import pool zfs
zpool import -d zpoolexport/ otus
#Download archive to home
wget -O otus_task2.file --no-check-certificate 'https://drive.usercontent.google.com/download?id=1wgxjih8YZ-cqLqaZVa0lA3h3Y029c3oI&export=download'
#Restore from snapshot
zfs receive otus/test@today < otus_task2.file
#Secret_message
find /otus/test -name "secret_message" -exec cat {} +

