# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.box = "shekeriev/centos-stream-9"
    monitoring.vm.hostname = "monitoring.do1.exam"
    monitoring.vm.network "private_network", ip: "192.168.150.203"
    monitoring.vm.provision "shell", path: "provision-scripts/add-hosts.sh"
    monitoring.vm.provision "shell", path: "provision-scripts/add-elk.sh"
    monitoring.vm.provision "shell", path: "provision-scripts/firewall.sh"
  
    monitoring.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 4096
      v.cpus = 1
    end
  end
  
  config.vm.define "pipelines" do |pipelines|
    pipelines.vm.box = "shekeriev/centos-stream-9"
    pipelines.vm.hostname = "pipelines.do1.exam"
    pipelines.vm.network "private_network", ip: "192.168.150.201"
    pipelines.vm.network "forwarded_port", guest: 80, host: 8000
    pipelines.vm.network "forwarded_port", guest: 8080, host: 8080
    pipelines.vm.provision "shell", path: "provision-scripts/add-hosts.sh"
    pipelines.vm.provision "shell", path: "provision-scripts/mbpipelines.sh"
    pipelines.vm.provision "shell", path: "provision-scripts/install_jenkins.sh"
    pipelines.vm.provision "shell", path: "provision-scripts/firewall.sh"
  
    pipelines.vm.provider "virtualbox" do |v|
        v.gui = false
        v.memory = 4096
        v.cpus = 1
    end
  end
  
  config.vm.define "containers" do |containers|
    containers.vm.box = "shekeriev/centos-stream-9"
    containers.vm.hostname = "containers.do1.exam"
    containers.vm.network "private_network", ip: "192.168.150.202"
    containers.vm.provision "shell", path: "provision-scripts/add-hosts.sh"
    containers.vm.provision "shell", path: "provision-scripts/add-docker.sh"
    containers.vm.provision "shell", path: "provision-scripts/mbcontainers.sh"
    containers.vm.provision "shell", path: "provision-scripts/setup-gitea.sh"
    containers.vm.provision "shell", path: "provision-scripts/firewall.sh"

    containers.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 4096
      v.cpus = 1
    end
  end
end
