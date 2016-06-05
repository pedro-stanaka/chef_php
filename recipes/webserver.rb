# Nginx Configuration

include_recipe 'php'
include_recipe 'nginx'
include_recipe 'php_chef::php_extensions'

user 'www-data' do
  comment 'Default web server user'
  gid 'www-data'
  shell '/usr/bin/zsh'
end

php_fpm_pool 'default' do
  action :install
  listen node['php_chef']['webserver']['php_fpm_url']
  user 'www-data'
  group 'www-data'
end

template "#{node['nginx']['dir']}/sites-available/#{node['php_chef']['appname']}" do
  source 'nginx-php.conf.erb'
  notifies :restart, 'service[nginx]'
end

directory "/var/www/#{node['php_chef']['appname']}" do
  mode '0755'
  user node['php_chef']['user']
  group 'www-data'
  action :create
  recursive true
end

directory '/var/www/logs/' do
  user 'www-data'
  group 'www-data'
  mode '0755'
  action :create
  recursive true
end

directory "/var/www/logs/#{node['php_chef']['appname']}" do
  user 'www-data'
  group 'www-data'
  mode '0755'
  action :create
  recursive true
end

cookbook_file "#{node['php_chef']['document_root']}/index.php" do
  mode '0775'
end

nginx_site 'default' do
  enable false
end

nginx_site node['php_chef']['appname'] do
  enable true
  notifies :restart, 'service[nginx]'
end

if !platform_family?('rhel', 'fedora')
  %w(redis intl).each do |pkg|
    php_pear pkg do
      action :install
    end
  end
else # On rhel and fedora install intl via package
  php_pear 'redis' do
    action :install
  end
end
