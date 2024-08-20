#!/bin/bash

#### install httpd ####

yum install -y httpd
systemctl enable httpd
firewall-offline-cmd --add-port=80/tcp