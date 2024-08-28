### created by Bryan Stewart
### bryan.stewart.2015@gmail.com
### date modified 20240819

##### system install method ####

%include https://raw.githubusercontent.com/rtfmorgtfo/kickstart/cleanup/baselines/installer.ks

##### install repositories ####

%include https://raw.githubusercontent.com/rtfmorgtfo/kickstart/main/baselines/repos.ks

##### addon Kdump file ####

%include https://raw.githubusercontent.com/rtfmorgtfo/kickstart/main/baselines/kdump.ks

##### networking information ####

%include https://raw.githubusercontent.com/rtfmorgtfo/kickstart/main/baselines/networking/webserver-02.ks

##### packages #####

%include https://raw.githubusercontent.com/rtfmorgtfo/kickstart/cleanup/baselines/packages/docker-packages.ks

##### password #####

%include https://raw.githubusercontent.com/rtfmorgtfo/kickstart/main/baselines/passwords/v1.ks

##### Timezone #####

%include https://raw.githubusercontent.com/rtfmorgtfo/kickstart/main/baselines/timezones/cst.ks

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
  ######## host update update script ###########

  #curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/scripts/update.sh              | /bin/bash


  ######## Docker install and system enable/start docker service ###########

  curl -sk https://raw.githubusercontent.com/rtfmorgtfo/kickstart/main/baselines/distro/el/post/docker.sh    | /bin/bash


  ######## Docker-compose makes individual docker containers with for loop for index files #########

  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/docker/docker-compose-httpd.sh | /bin/bash


  ######## Creates docker launcher ########

  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/scripts/create-launcher.sh     | /bin/bash


  ######## adds execute permission to /usr/local/bin/bsweb and /sbin/bsweb.sh ############

  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/scripts/chmod-bsweb.sh         | /bin/bash


  ######## creates cron job reboots /sbin/bsweb.sh and removes /etc/cron.d/bsweb ########$

  curl -sk https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/scripts/cron-job.sh            | /bin/bash

  chvt 1
%end

### Disk Clearing sda

%include https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/include/partition-clearing-information.ks

# Disk partitioning information
%include https://raw.githubusercontent.com/RTFMorGTFO/kickstart/main/include/system-volumes.ks

