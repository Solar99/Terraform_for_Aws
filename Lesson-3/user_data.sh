#!/bin/base
yum -y update
yum -y install
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2> WebServer with IP: $myip</h2><br>Build by Terraform Using External Script" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
