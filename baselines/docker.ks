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
  exec < /dev/tty6 > /dev/tty6
  chvt 6

  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/banner/banner.txt
  
  chvt 1
%end

###### post #####

%post
  exec < /dev/tty6 > /dev/tty6
  chvt 6

  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/scripts/update.sh | /bin/bash
  curl -sk https://raw.githubusercontent.com/927technology/kickstart/main/distro/el/post/docker.sh | /bin/bash
  
  mkdir -p /etc/bsweb
   
cat << EOF-compose > /etc/bsweb/docker-compose.yml
name: bsweb

services:
  bsweb:
    container_name: bsweb
      
  hostname: bsweb
  image: bstewart1992/bsweb:0.6
  ports:
    - target: 8080
      published: 80
      protocol: tcp
  restart: always

EOF-compose

# create launcher
cat << EOF-launcher > /sbin/bsweb.sh
#!/bin/bash
/usr/local/bin/docker-compose -f /etc/bsweb/docker-compose.yml up --detach
EOF-launcher

chmod +x /sbin/bsweb.sh

# create cron job
cat << EOF-cron > /etc/cron.d/bsweb
@reboot root /sbin/bsweb.sh && rm -f /etc/cron.d/bsweb
EOF-cron

chmod +x /usr/local/bin/bsweb

  chvt 1
%end

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=static --device=enp0s3 --gateway=192.168.1.1 --ip=192.168.1.200 --nameserver=8.8.8.8 --netmask=255.255.255.0 --ipv6=auto --activate
network  --hostname=webserver-02

# Use CDROM installation media
cdrom

%packages
@^minimal-environment

%end

# Run the Setup Agent on first boot
firstboot --enable

### Disk Clearing sda

%include https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/include/partition-clearing-information.ks

# Disk partitioning information
%include https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/include/system-volumes.ks

# System timezone
timezone America/Chicago --utc

# Root password
rootpw --iscrypted --allow-ssh $6$rKLW2O5tk2tLvXpv$JJTNhX261Q5WIO.pLkf6Pp9wz3LxyVZySqMnTjp0fee3AH51oI5Fd0Yqh7WhqTEygHN1DgbyRI.V0yg5qo0Gt/

