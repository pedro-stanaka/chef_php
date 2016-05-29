#
# Cookbook Name:: rpdevel
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#






include_recipe 'nginx'
include_recipe 'vim'
include_recipe 'zsh'
include_recipe 'lxmx_oh_my_zsh'


# Users and Groups Stuff...
group node['php_chef']['group']

user node['php_chef']['user'] do
  system true
  group node['php_chef']['group']
  shell '/usr/bin/zsh'
end

lxmx_oh_my_zsh_user node['php_chef']['user'] do
  plugins        %w{git ruby rvm}
  home 			 "/home/#{node['php_chef']['user']}"
  autocorrect    false
  case_sensitive true
end

lxmx_oh_my_zsh_user vagrant do
  plugins        %w{git ruby rvm}
  home 			 "/home/#{node['php_chef']['user']}"
  autocorrect    false
  case_sensitive true
end

