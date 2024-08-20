FROM oraclelinux:7
#RUN yum check-update
RUN yum update -y
RUN yum install httpd php nano -y
CMD ["/sbin/apachectl1","-D","FOREGROUND"]