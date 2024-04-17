#!/bin/bash

sudo yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y
sudo sed -i s/#SOCKET/SOCKET/g /etc/sysconfig/spawn-fcgi
sudo sed -i s/#OPTIONS/OPTIONS/g /etc/sysconfig/spawn-fcgi
sudo cp /vagrant/newunit/spawn-fcgi.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now spawn-fcgi