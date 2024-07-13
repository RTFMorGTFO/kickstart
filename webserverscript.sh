#!/bin/bash
#update the meta data
yum check-update
#update security patching (suggest creating loop to do a second round)
yum update -y
if [[ $? != 0 ]] ; then
    yum update -y
fi
# install  httpd
yum install httpd -y
if [[ $? != 0 ]] ; then
    yum install httpd -y
fi
# start httpd services
systemctl start httpd
if [[ $? != 0 ]] ; then
    systemctl start httpd
fi
# enable the httpd service
systemctl enable httpd
#allow port 80 through the firewall
firewall-cmd --permanent --zone=public --add-port=80/tcp
if [[ $? == 0 ]] ; then
    firewall-cmd --reload
else 
    echo firewall rule did not apply
fi
#creating default landing page
echo hello world > /var/www/html/index.html
chown root:apache /var/www/html/index.html
chmod 640 /var/www/html/index.html
