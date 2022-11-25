#!/bin/bash

sudo firewall-cmd --add-port 8080/tcp --permanent
sudo firewall-cmd --add-port 80/tcp --permanent
sudo firewall-cmd --add-port 5000/tcp --permanent
sudo firewall-cmd --add-port 5601/tcp --permanent
sudo firewall-cmd --add-port 9200/tcp --permanent
sudo firewall-cmd --add-port 9300/tcp --permanent
sudo firewall-cmd --add-port 5044/tcp --permanent
sudo firewall-cmd --add-port 3000/tcp --permanent
firewall-cmd --reload