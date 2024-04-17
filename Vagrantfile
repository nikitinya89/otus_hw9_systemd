# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box  = "Centos/7"
  config.vm.provision "shell", path: "monitor/monitor.sh", name: "monitor", run: "once"
  config.vm.provision "shell", path: "newunit/newunit.sh", name: "newunit", run: "once"
  config.vm.provision "shell", path: "httpd/httpd.sh", name: "httpd", run: "once"
end