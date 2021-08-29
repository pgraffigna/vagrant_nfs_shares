# -*- mode: ruby -*-
# vi: set ft=ruby :

imagen="debian/buster64"

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :virtualbox do |vb|
    vb.memory = 512
    vb.cpus = 1
    vb.check_guest_additions = false 
  end 
  
  config.vm.define "server" do |srv|
    srv.vm.box = imagen
    srv.vm.hostname = "nfs-server"
    srv.vm.network :private_network, ip: "192.168.60.3"
    srv.vm.provision "shell", path: "nfs-server.sh"
  end

  config.vm.define "client" do |cl|
    cl.vm.box = imagen
    cl.vm.hostname = "nfs-client"
    cl.vm.network :private_network, ip: "192.168.60.4"
    cl.vm.provision "shell", path: "nfs-client.sh"
  end
end
