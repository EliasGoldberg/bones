yum install -y haproxy
cp /vagrant/files/haproxy.cfg /etc/haproxy/haproxy.cfg
systemctl start haproxy
systemctl enable haproxy
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
echo '$ModLoad imudp' >> /etc/rsyslog.conf
echo '$UDPServerRun 514' >> /etc/rsyslog.conf
echo "local2.*                       /var/log/haproxy.log" > /etc/rsyslog.d/haproxy.conf
systemctl restart rsyslog
