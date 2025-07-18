#!/bin/bash
yum update -y
yum install -y nginx
systemctl start nginx
systemctl enable nginx
echo "<h1>Deployed with external user_data.sh</h1>" > /usr/share/nginx/html/index.html