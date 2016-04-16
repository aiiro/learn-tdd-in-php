yum_repository 'remi' do
  description 'Les RPM de Remi - Repository'
  baseurl 'http://rpms.famillecollet.com/enterprise/7/remi/x86_64/'
  gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
  fastestmirror_enabled true
  action :create
end

yum_repository 'remi-php70' do
  description 'Les RPM de remi de PHP 7 pour Enterprise Linux 7'
  baseurl 'http://rpms.famillecollet.com/enterprise/7/php70/$basearch/'
  gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
  fastestmirror_enabled true
  action :create
end

%w{php php-fpm php-cli php-common php-devel php-json php-mysql php-mbstring php-mcrypt php-opcache
    php-pdo php-pear php-pecl-memcached php-pecl-zip php-process}.each do |pkg|
  package pkg do
    action :install
    notifies :restart, "service[php-fpm]"
  end
end

service "php-fpm" do
  action [:enable, :start]
end
