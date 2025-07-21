#!/bin/bash
set -e

yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

cat <<EOF > /var/www/html/index.html
<h1>Deployed using Terraform + Shell Script</h1>
EOF
systemctl restart httpd