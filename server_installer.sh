# SQL server shell file
# created by Bryan Stewart 07/10/2024
# date of last edit 07/10/2024

# Functions
package_install (){
    local _package=${1}
    yum install ${_package} -y
    if [[ ${?} != 0 ]] ; then
        yum install ${_package} -y
    fi
}

start_service (){
    # Variables
    local _service=${1}
    
    # Main
    systemctl start ${_service}
    if [[ ${?} != 0 ]] ; then
        systemctl start ${_service}
    fi

    # enable services
    systemctl enable ${_service} > /dev/null 2&>1
}

firewall_port_passthrough (){
    # Variables
    local _firewall_port=${1}
    local _firewall_protocol=${2}

    if [[ ${firewall_enable} == 1 ]]; then
        firewall-offline-cmd --zone=public --add-port=${firewall_port}/${firewall_protocol}
        if [[ ${?} == 0 ]] ; then
            firewall-offline-cmd --reload
        else 
            echo firewall rule did not apply
        fi
    fi

# Variables
package=mariadb-server
service=mariadb
firewall_enable=1
firewall_port=3306
firewall_protocol=tcp

# check for updates
yum check-update

# update security patching
yum update -y
if [[ ${?} != 0 ]] ; then
    yum update -y
fi

# install  mariadb-server
package_install ${package} 

# start mariadb services
start_service ${service}

# allow port 3306 through the firewall
if [[ ${firewall_enable} == 1 ]]; then
    firewall-offline-cmd --zone=public --add-port=${firewall_port}/${firewall_protocol}
    if [[ ${?} == 0 ]] ; then
        firewall-offline-cmd --reload
    else 
        echo firewall rule did not apply
    fi
fi