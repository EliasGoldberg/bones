cp /vagrant/files/logstash-forwarder.crt /etc/pki/tls/certs/logstash-forwarder.crt
systemctl restart topbeat
systemctl restart filebeat
