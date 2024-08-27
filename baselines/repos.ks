##### respositories #####
#repo --name="AppStream" --baseurl=file:///run/install/sources/mount-0000-cdrom/AppStream

# YUM Repisitories
repo --name="baseos" --baseurl="https://public-yum.oracle.com/repo/OracleLinux/OL9/baseos/latest/x86_64/"
repo --name="UEKR7" --baseurl="https://public-yum.oracle.com/repo/OracleLinux/OL9/UEKR7/x86_64/"
repo --name="AppStream" --baseurl="https://public-yum.oracle.com/repo/OracleLinux/OL9/appstream/x86_64/"

# Use Network installation
#url --url="https://yum.oracle.com/repo/OracleLinux/OL9/baseos/latest/x86_64"
url --url="https://public-yum.oracle.com/repo/OracleLinux/OL9/baseos/latest/x86_64"