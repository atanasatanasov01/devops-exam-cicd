#!/bin/bash

echo "* Installing Elasticsearch and configuring it"
wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.4.3-x86_64.rpm
sudo rpm -Uvh elasticsearch-*.rpm

sudo cp /vagrant/configs/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo cp /vagrant/configs/jvm.options /etc/elasticsearch/jvm.options.d/jvm.options

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

echo "* Installing Logstash and configuring it"
wget -q https://artifacts.elastic.co/downloads/logstash/logstash-8.4.3-x86_64.rpm
sudo rpm -Uvh logstash-*.rpm

sudo cp /vagrant/configs/jvmls.options /etc/logstash/jvm.options

sudo systemctl daemon-reload
sudo systemctl enable logstash
sudo systemctl start logstash

echo "* Installing Kibana and configuring it"
wget -q https://artifacts.elastic.co/downloads/kibana/kibana-8.4.3-x86_64.rpm
sudo rpm -Uvh kibana-*.rpm

sudo cp /vagrant/configs/kibana.yml /etc/kibana/kibana.yml

sudo systemctl daemon-reload
sudo systemctl enable kibana
sudo systemctl start kibana

sudo cp /vagrant/configs/beats.conf /etc/logstash/conf.d/beats.conf
sudo systemctl restart logstash