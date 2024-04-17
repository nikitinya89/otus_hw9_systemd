#!/bin/bash

sudo cp /vagrant/monitor/homework.log /var/log/
sudo cp /vagrant/monitor/otus-mon-env /etc/sysconfig/
sudo cp /vagrant/monitor/otusmon.service /etc/systemd/system/
sudo cp /vagrant/monitor/otusmon.timer /etc/systemd/system/
sudo cp /vagrant/monitor/otusmon.sh /opt/
sudo chmod +x /opt/otusmon.sh
sudo systemctl daemon-reload
sudo systemctl enable --now otusmon.timer
sudo systemctl start otusmon.service