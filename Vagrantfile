# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos7.1-tdd"
  config.vm.network "private_network", ip: "192.168.33.10"
  # vagrant-omnibus
  config.omnibus.chef_version = :latest
  # vagrant-cachier
  config.cache.scope = :box
end
