#
# Cookbook Name:: rpdevel
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#



group node['php_chef']['group']

user node['php_chef']['user'] do
  system true
  group node['php_chef']['group']
  shell '/bin/bash'
end


include_recipe 'nginx'
include_recipe 'vim'
include_recipe 'zsh'


