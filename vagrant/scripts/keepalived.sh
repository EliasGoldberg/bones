yum install -y keepalived
cp /vagrant/files/keepalived.conf /etc/keepalived/keepalived.conf
sed -i "s/@STATE/$1/" /etc/keepalived/keepalived.conf
sed -i "s/@PRIORITY/$2/" /etc/keepalived/keepalived.conf
sed -i "s/@SRC/$3/" /etc/keepalived/keepalived.conf
sed -i "s/@PEER/$4/" /etc/keepalived/keepalived.conf
systemctl enable keepalived
systemctl start keepalived
