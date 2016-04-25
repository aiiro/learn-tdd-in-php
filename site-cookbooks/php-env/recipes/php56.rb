yum_repository 'remi' do
  description 'Les RPM de Remi - Repository'
  baseurl 'http://rpms.famillecollet.com/enterprise/7/remi/x86_64/'
  gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
  action :create
end

yum_repository 'remi-php56' do
  description 'Les RPM de remi de PHP 5.6 pour Enterprise Linux 7'
  baseurl 'http://rpms.famillecollet.com/enterprise/7/php56/$basearch/'
  gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
  action :create
end

%w{php56 php56-php-fpm php56-php-cli php56-php-common php56-php-devel php56-php-json php56-php-mysql php56-php-mbstring php56-php-mcrypt php56-php-opcache
    php56-php-pdo php56-php-pear php56-php-pecl-memcached php56-php-pecl-zip php56-php-process php56-php-xdebug graphviz}.each do |pkg|
  package pkg do
    action :install
    notifies :restart, "service[php56-php-fpm]"
  end
end

service "php56-php-fpm" do
  action [:enable, :start]
end

remote_file "/usr/local/bin/composer" do
  source "http://getcomposer.org/composer.phar"
  action :create_if_missing
  owner "root"
  group "root"
  mode 0755
end

remote_file "/usr/local/bin/phpdoc" do
  source "http://www.phpdoc.org/phpDocumentor.phar"
  action :create_if_missing
  owner "root"
  group "root"
  mode 0755
end
