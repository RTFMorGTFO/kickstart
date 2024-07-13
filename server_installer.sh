# SQL server shell file
# created by Bryan Stewart 07/10/2024
# date of last edit 07/10/2024

# Configuration Source
source /tmp/server.conf

# Functions Source
source /tmp/library.f

#  System update
update_upgrade

# install  mariadb-server
package_install ${package} 

# start mariadb services
start_service ${service}

# allow port 3306 through the firewall
firewall_port_passthrough ${firewall_port} ${firewall_protocol}
