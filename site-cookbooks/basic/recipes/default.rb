package "yum-fastestmirror" do
  action :install
end

execute "set-timezone" do
  user "root"
  command "timedatectl set-timezone Asia/Tokyo"
  action :run
end

execute "yum-update" do
  user "root"
  command "yum -y update"
  action :run
end

%w{vim git}.each do |pkg|
  package pkg do
    action :install
  end
end

hostsfile_entry '127.0.0.1' do
  hostname  'test.localhost'
  action    :append
end
