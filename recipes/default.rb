#
# Cookbook Name:: rpdevel
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Including inner recipes

include_recipe 'php_chef::bootstraping'
include_recipe 'php_chef::webserver'

