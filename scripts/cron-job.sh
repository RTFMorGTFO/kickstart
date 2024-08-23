#!/bin/bash

# create cron job
cat << EOF-cron > /etc/cron.d/bsweb
@reboot root /sbin/bsweb.sh && rm -f /etc/cron.d/bsweb
EOF-cron