# SQL server kick start file
# created by Bryan Stewart 07/10/2024
# date of last edit 07/10/2024

#graphical
text
repo --name="AppStream" --baseurl=file:///run/install/sources/mount-0000-cdrom/AppStream

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

# Keyboard layouts
keyboard --xlayouts='us'

# System language
lang en_US.UTF-8

# Network information
#network  --bootproto=static --device=enp0s3 --gateway=10.0.2.1 --ip=10.0.2.71 --nameserver=8.8.8.8 --netmask=255.255.255.0 --ipv6=auto --activate
network  --bootproto=dhcp --device=enp0s3
network  --hostname=sqlserver

# Reboot line
reboot --eject

# Use CDROM installation media
cdrom

%packages
@^minimal-environment
curl
nano

%end

# Run the Setup Agent on first boot
firstboot --enable

# Generated using Blivet version 3.6.0
ignoredisk --only-use=sda

# Partition clearing information
clearpart --none --initlabel

# Disk partitioning information
part /boot --fstype="xfs" --ondisk=sda --size=1024
part pv.643 --fstype="lvmpv" --ondisk=sda --size=22024
volgroup System --pesize=4096 pv.643
logvol / --fstype="xfs" --size=8192 --name=root --vgname=System
logvol /home --fstype="xfs" --size=1024 --name=home --vgname=System
logvol swap --fstype="swap" --size=4096 --name=swap --vgname=System
logvol /tmp --fstype="xfs" --size=512 --name=tmp --vgname=System
logvol /var --fstype="xfs" --size=2048 --name=var --vgname=System
logvol /var/log/audit --fstype="xfs" --size=2048 --name=var_log_audit --vgname=System
logvol /var/log --fstype="xfs" --size=2048 --name=var_log --vgname=System
logvol /var/lib/mysql --fstype="xfs" --size=2048 --name=var_lib_mysql --vgname=System

# System timezone
timezone America/Chicago --utc

# Root password
rootpw --iscrypted --allow-ssh $6$fypfDGbjE8cEarp1$WSdslt2rk9ZWjrfqPxgKo2S53E.tDIW6ut2hE/EeuxGoXYApOcI.NywBNSVREl1sVpENbllLI1WKcGfcxPJIf.

# added post script line
%post
curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/banner.txt
#curl http://10.0.2.69/sqlserverscript.sh | /bin/bash
curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/sqlserver.conf > /tmp/server.conf
curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/library.f > /tmp/library.f
curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/server_installer.sh > /tmp/server_installer.sh
chmod +x /tmp/server_installer.sh
/tmp/server_installer.sh
%end