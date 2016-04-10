# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    # vagrant-cachier
    config.cache.scope = :box
  end
  # 1st virtual server
  config.vm.define :develop do |develop|
    # vagrant-omnibus
    develop.omnibus.chef_version = :latest
    develop.vm.hostname = "develop"
    develop.vm.box = "centos7.1-tdd"
    develop.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7cd.1/vagrant-centos-7.1.box"
    develop.vm.network "private_network", ip: "192.168.33.10"
  end
  # 2nd virtual server
  config.vm.define :ci do |ci|
    # vagrant-omnibus
    ci.omnibus.chef_version = :latest
    ci.vm.hostname = "ci"
    ci.vm.box = "centos7.1-tdd"
    ci.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7cd.1/vagrant-centos-7.1.box"
    ci.vm.network "private_network", ip: "192.168.33.11"
  end
  # 3rd virtual server
  config.vm.define :staging do |staging|
    # vagrant-omnibus
    staging.omnibus.chef_version = :latest
    staging.vm.hostname = "staging"
    staging.vm.box = "centos7.1-tdd"
    staging.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7cd.1/vagrant-centos-7.1.box"
    staging.vm.network "private_network", ip: "192.168.33.12"
  end
end
