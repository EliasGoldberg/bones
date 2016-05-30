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

firewall-cmd --zone=public --add-port=5044/tcp --permanent
firewall-cmd --reload
