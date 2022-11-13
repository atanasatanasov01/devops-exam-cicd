#!/bin/bash


wget -q https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.4.3-x86_64.rpm
sudo rpm -Uvh metricbeat-8.4.3-x86_64.rpm

sudo cp /vagrant/configs/metricbeat.yml /etc/metricbeat/metricbeat.yml
sudo metricbeat modules enable system
sudo metricbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.150.203:9200"]'
sudo systemctl daemon-reload
sudo systemctl enable metricbeat
sudo systemctl start metricbeat
