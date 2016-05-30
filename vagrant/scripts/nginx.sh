cp /vagrant/files/nginx.repo /etc/yum.repos.d/nginx.repo
yum install -y nginx
cp /vagrant/files/$1 /etc/nginx/conf.d/default.conf
systemctl start nginx
systemctl enable nginx

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
