curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
yum install -y nodejs
yum install -y gcc-c++ make

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
