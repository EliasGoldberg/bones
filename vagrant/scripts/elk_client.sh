cp /vagrant/files/logstash-forwarder.crt /etc/pki/tls/certs/logstash-forwarder.crt
rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
echo '[beats]
name=Elastic Beats Repository
baseurl=https://packages.elastic.co/beats/yum/el/$basearch
enabled=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
gpgcheck=1' > /etc/yum.repos.d/elastic-beats.repo

yum -y install filebeat
cp /vagrant/files/filebeat.yml /etc/filebeat/filebeat.yml
systemctl start filebeat
systemctl enable filebeat

yum install -y topbeat
cp /vagrant/files/topbeat.yml /etc/topbeat/topbeat.yml
systemctl start topbeat
systemctl enable topbeat

yum install -y packetbeat
cp /vagrant/files/packetbeat.yml /etc/packetbeat/packetbeat.yml
systemctl start packetbeat
systemctl enable packetbeat

firewall-cmd --zone=public --add-port=5044/tcp --permanent
firewall-cmd --reload
