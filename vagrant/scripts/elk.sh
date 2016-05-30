rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
echo '[elasticsearch-2.x]
name=Elasticsearch repository for 2.x packages
baseurl=http://packages.elastic.co/elasticsearch/2.x/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1' > /etc/yum.repos.d/elasticsearch.repo
yum -y install elasticsearch
echo 'network.host: localhost' > /etc/elasticsearch/elasticsearch.yml
systemctl start elasticsearch
systemctl enable elasticsearch

echo '[kibana-4.4]
name=Kibana repository for 4.4.x packages
baseurl=http://packages.elastic.co/kibana/4.4/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1' > /etc/yum.repos.d/kibana.repo
yum -y install kibana
echo 'server.host: "localhost"' > /opt/kibana/config/kibana.yml
systemctl start kibana
systemctl enable kibana

echo '[logstash-2.2]
name=logstash repository for 2.2 packages
baseurl=http://packages.elasticsearch.org/logstash/2.2/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1' > /etc/yum.repos.d/logstash.repo
yum -y install logstash

sed -i '/\[ v3_ca \]/a \
subjectAltName = IP: 172.28.128.7' /etc/pki/tls/openssl.cnf
cd /etc/pki/tls
openssl req -config /etc/pki/tls/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
cd ~
cp /etc/pki/tls/certs/logstash-forwarder.crt /vagrant/files/logstash-forwarder.crt

echo 'input {
  beats {
    port => 5044
    ssl => true
    ssl_certificate => "/etc/pki/tls/certs/logstash-forwarder.crt"
    ssl_key => "/etc/pki/tls/private/logstash-forwarder.key"
  }
}' > /etc/logstash/conf.d/02-beats-input.conf
echo 'filter {
  if [type] == "syslog" {
    grok {
      match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
      add_field => [ "received_at", "%{@timestamp}" ]
      add_field => [ "received_from", "%{host}" ]
    }
    syslog_pri { }
    date {
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    }
  }
}' > /etc/logstash/conf.d/10-syslog-filter.conf
echo 'output {
  elasticsearch {
    hosts => ["localhost:9200"]
    sniffing => true
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
}' > /etc/logstash/conf.d/30-elasticsearch-output.conf
systemctl start logstash
chkconfig logstash on

curl -L -O https://download.elastic.co/beats/dashboards/beats-dashboards-1.1.0.zip
yum -y install unzip
unzip beats-dashboards-*.zip
cd beats-dashboards-*
./load.sh
cd ~

curl -O https://gist.githubusercontent.com/thisismitch/3429023e8438cc25b86c/raw/d8c479e2a1adcea8b1fe86570e42abab0f10f364/filebeat-index-template.json
curl -XPUT 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat-index-template.json

firewall-cmd --zone=public --add-port=5044/tcp --permanent
firewall-cmd --reload
