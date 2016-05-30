#
# Cookbook Name:: rpdevel
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#


# Including recipes
include_recipe 'nginx'
include_recipe 'vim'
include_recipe 'zsh'
include_recipe 'lxmx_oh_my_zsh'
include_recipe 'tmux'




# Users and Groups Stuff...
group node['php_chef']['group']

user node['php_chef']['user'] do
  system true
  group node['php_chef']['group']
  group 'www-data'
  shell '/usr/bin/zsh'
end

group 'www-data' do
  action :modify
  members ['vagrant', node['php_chef']['user']]
  append true
end


lxmx_oh_my_zsh_user node['php_chef']['user'] do
  plugins        %w{git ruby rvm bower debian node npm tmux}
  home 			 "/home/#{node['php_chef']['user']}"
  theme          "steeef"
  autocorrect    false
  case_sensitive true
end

lxmx_oh_my_zsh_user 'vagrant' do
  plugins        %w{git ruby rvm bower debian node npm tmux}
  home 			     "/home/vagrant"
  theme          "steeef"
  autocorrect    false
  case_sensitive true
end

# Networking

hostsfile_entry '127.0.0.1' do 
  hostname "#{node['php_chef']['servername']}"
  action :append
end

# Nginx Configuration

template "#{node['nginx']['dir']}/sites-available/#{node['php_chef']['appname']}" do
  source 'nginx-basic.conf.erb'
  notifies :restart, 'service[nginx]'
end


directory "/var/www/#{node['php_chef']['appname']}" do
  mode '0755'
  action :create
  recursive true
end

directory "/var/www/logs/" do
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


cookbook_file "/var/www/#{node['php_chef']['appname']}/index.html" do
  mode '0644'
end

nginx_site "default" do 
  enable false
end

nginx_site "#{node['php_chef']['appname']}" do 
  enable true
  notifies :restart, 'service[nginx]'
end