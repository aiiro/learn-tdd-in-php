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

    develop.vm.synced_folder "application", "/var/www/application/current",
    id: "vagrant-root", :nfs => false,
    :create => true,
    :owner => "vagrant",
    :group => "vagrant",
    :mount_options => ["dmode=777,fmode=777"]

    # provision setting
    develop.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "./cookbooks"
      chef.json = {
        nginx: {
          docroot: {
            owner: "vagrant",
            group: "vagrant",
            path: "/var/www/application/current/app/webroot",
            force_create: true
          },
          default: {
            fastcgi_params: {  CAKE_ENV: "development" }
          },
          test: {
            available: true,
            fastcgi_params: {  CAKE_ENV: "test" }
          },
          env: ["php"]
        }
      }

      chef.run_list = %w[
        recipe[yum]
        recipe[yum-epel]
        recipe[basic]
        recipe[nginx]
        recipe[php-env::php56]
        recipe[mariadb]
        recipe[ruby-env]
        recipe[capistrano]
        recipe[jenkins::rpm]
        recipe[jenkins::plugin]
      ]
    end
  end
  # 2nd virtual server
  config.vm.define :ci do |ci|
    # vagrant-omnibus
    ci.omnibus.chef_version = :latest
    ci.vm.hostname = "ci"
    ci.vm.box = "centos7.1-tdd"
    ci.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7cd.1/vagrant-centos-7.1.box"
    ci.vm.network "private_network", ip: "192.168.33.11"

    # provision setting
    ci.vm.provision :chef_solo do |chef|
      chef.log_level = "debug"
      chef.cookbooks_path = "./cookbooks"
      chef.json = {
        nginx: {
          docroot: {
            path: "/var/lib/jenkins/jobs/blogapp/workspace/app/webroot",
            force_create: true
          },
          default: {
            fastcgi_params: { CAKE_ENV: "development" }
          },
          test: {
            available: true,
            fastcgi_params: { CAKE_ENV: "ci" }
          },
          env: ["php"]
        }
      }
      chef.run_list = %w[
        recipe[yum]
        recipe[yum-epel]
        recipe[basic]
        recipe[nginx]
        recipe[php-env::php56]
        recipe[mariadb]
        recipe[ruby-env]
        recipe[capistrano]
        recipe[jenkins::rpm]
        recipe[jenkins::plugin]
      ]
    end
  end
  # 3rd virtual server
  config.vm.define :staging do |staging|
    # vagrant-omnibus
    staging.omnibus.chef_version = :latest
    staging.vm.hostname = "staging"
    staging.vm.box = "centos7.1-tdd"
    staging.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7cd.1/vagrant-centos-7.1.box"
    staging.vm.network "private_network", ip: "192.168.33.12"

    # provision setting
    staging.vm.provision :chef_solo do |chef|
      chef.log_level = "debug"
      chef.cookbooks_path = "./cookbooks"
      chef.json = {
        nginx: {
          docroot: {
            owner: "vagrant",
            group: "vagrant",
            path: "/var/www/application/current/app/webroot",
            force_create: true
          },
          default: {
            fastcgi_params: {  CAKE_ENV: "production" }
          },
          env: ["php"]
        }
      }
      chef.run_list = %w[
        recipe[yum]
        recipe[yum-epel]
        recipe[basic]
        recipe[nginx]
        recipe[php-env::php56]
        recipe[mariadb]
      ]
    end

  end
end
