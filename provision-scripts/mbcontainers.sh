#!/bin/bash


docker-compose -f /vagrant/docker-compose.yml up -d

dnf update
sudo dnf install -y -q java-17-openjdk git

wget -q https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.4.3-x86_64.rpm
sudo rpm -Uvh metricbeat-8.4.3-x86_64.rpm

sudo cp /vagrant/configs/metricbeat.yml /etc/metricbeat/metricbeat.yml
sudo metricbeat modules enable system
sudo systemctl daemon-reload
sudo systemctl enable metricbeat
sudo systemctl start metricbeat