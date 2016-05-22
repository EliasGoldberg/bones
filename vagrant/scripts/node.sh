curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
yum install -y nodejs
yum install -y gcc-c++ make

yum install -y git
npm install pm2 -g
env PATH=$PATH:/usr/bin pm2 startup centos -u vagrant --hp /home/vagrant
echo vagrant | su - vagrant -c "pm2 start /vagrant/files/pm2.json"
echo vagrant | su - vagrant -c "pm2 save"
