package "java-1.8.0-openjdk" do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/jenkins-1.658-1.1.noarch.rpm" do
  source "http://pkg.jenkins-ci.org/redhat/jenkins-1.658-1.1.noarch.rpm"
  not_if "rpm -qa | grep -q '^jenkins'"
  action :create
  notifies :install, "rpm_package[jenkins]", :immediately
end

rpm_package "jenkins" do
  source "#{Chef::Config[:file_cache_path]}/jenkins-1.658-1.1.noarch.rpm"
  action :install
  not_if "rpm -q jenkins"
end

service "jenkins" do
  action [:enable, :start]
end
