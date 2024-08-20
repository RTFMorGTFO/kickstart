### created by Bryan Stewart
### bryan.stewart.2015@gmail.com
### date modified 20240819

text
reboot --eject
repo --name="AppStream" --baseurl=file:///run/install/sources/mount-0000-cdrom/AppStream

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

##### pre ####

%pre
  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/banner.txt

%end

###### post #####

%post

  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/update.sh | /bin/bash
  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/httpd.sh  | /bin/bash

%end

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=static --device=enp0s3 --gateway=192.168.1.1 --ip=192.168.1.200 --nameserver=8.8.8.8 --netmask=255.255.255.0 --ipv6=auto --activate
network  --hostname=webserver-01

# Use CDROM installation media
cdrom

%packages
@^minimal-environment

%end

# Run the Setup Agent on first boot
firstboot --enable

# Generated using Blivet version 3.6.0
ignoredisk --only-use=sda
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=sda --size=1024
part pv.503 --fstype="lvmpv" --ondisk=sda --size=16392
volgroup system --pesize=4096 pv.503
logvol /var/log --fstype="xfs" --size=2048 --name=var_log --vgname=system
logvol / --fstype="xfs" --size=4096 --name=root --vgname=system
logvol swap --fstype="swap" --size=4096 --name=swap --vgname=system
logvol /var --fstype="xfs" --size=2048 --name=var --vgname=system
logvol /var/log/audit --fstype="xfs" --size=2048 --name=var_log_audit --vgname=system
logvol /tmp --fstype="xfs" --size=1024 --name=tmp --vgname=system
logvol /home --fstype="xfs" --size=1024 --name=home --vgname=system

# System timezone
timezone America/Chicago --utc

# Root password
rootpw --iscrypted --allow-ssh $6$rKLW2O5tk2tLvXpv$JJTNhX261Q5WIO.pLkf6Pp9wz3LxyVZySqMnTjp0fee3AH51oI5Fd0Yqh7WhqTEygHN1DgbyRI.V0yg5qo0Gt/

