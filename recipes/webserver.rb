# Nginx Configuration

include_recipe 'php'
include_recipe 'nginx'

user 'www-data' do
  comment 'Default web server user'
  gid 'www-data'
  shell '/usr/bin/zsh'
end

php_fpm_pool 'www' do
  action :install
  listen '/var/run/php5-fpm.sock'
  user 'www-data'
  group 'www-data'
end

template "#{node['nginx']['dir']}/sites-available/#{node['php_chef']['appname']}" do
  source 'nginx-basic.conf.erb'
  notifies :restart, 'service[nginx]'
end

directory "/var/www/#{node['php_chef']['appname']}" do
  mode '0755'
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

cookbook_file "#{node['php_chef']['document_root']}/index.html" do
  mode '0644'
end

nginx_site 'default' do
  enable false
end

nginx_site node['php_chef']['appname'] do
  enable true
  notifies :restart, 'service[nginx]'
end
