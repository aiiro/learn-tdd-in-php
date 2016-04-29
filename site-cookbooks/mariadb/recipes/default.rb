yum_repository 'mariadb' do
  description 'MariaDB - Repository'
  baseurl 'http://yum.mariadb.org/10.1/centos7-amd64'
  gpgkey 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'
  action :create
end

%w{MariaDB-server MariaDB-client}.each do |pkg|
  package pkg do
    action :install
  end
end

service "mysql" do
  action [:enable, :start]
end
