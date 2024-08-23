#!/bin/bash

# create launcher
cat << EOF-launcher > /sbin/bsweb.sh
#!/bin/bash
/usr/local/bin/docker-compose -f /etc/bsweb/docker-compose.yml up --detach
EOF-launcher