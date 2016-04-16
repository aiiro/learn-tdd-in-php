include_recipe "yum-epel"

# install nginx
package "nginx" do
  action :install
end

# create DocumentRoot directory
directory node['nginx']['docroot']['path'] do
  owner node['nginx']['docroot']['owner']
  group node['nginx']['docroot']['group']
  mode 0755
  action :create
  recursive true
  only_if { not File.exists?(node['nginx']['docroot']['path']) and node['nginx']['docroot']['force_create']}
end

# copy default.conf
template "/etc/nginx/conf.d/default.conf" do
  source "default.conf.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
end

# copy test.conf
template "/etc/nginx/conf.d/test.conf" do
  source "test.conf.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
  only_if { node['nginx']['test']['available'] == true }
end

# copy nginx.conf
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
  notifies :reload, "service[nginx]"
end

# copy index.html
template node['nginx']['docroot']['path']+"/index.html" do
  source "index.html.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
end

# copy index.php
template node['nginx']['docroot']['path']+"/index.php" do
  source "index.php.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
end

# start nginx
service "nginx" do
  action [:enable, :start]
  supports :status => true, :restart => true, :reload => true
end
