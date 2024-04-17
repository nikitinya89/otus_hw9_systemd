#!/bin/bash
sudo setenforce 0
sudo cp /vagrant/httpd/httpd-{1,2} /etc/sysconfig/
sudo cp /vagrant/httpd/httpd-{1,2}.conf /etc/httpd/conf/
sudo cp /vagrant/httpd/httpd@.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start httpd@1
sudo systemctl start httpd@2