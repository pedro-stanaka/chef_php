
# Including recipes

execute 'apt-get update' do
  command 'apt-get update --fix-missing --quiet'
  action :run
  only_if { platform_family?('debian') }
end

include_recipe 'vim'
include_recipe 'zsh'
include_recipe 'tmux'
include_recipe 'htop'
include_recipe 'git'
include_recipe 'curl'
include_recipe 'zlib'
include_recipe 'locale' if platform?('ubuntu')
include_recipe 'user::data_bag'
include_recipe 'lxmx_oh_my_zsh'

package 'Rubies source deps' do
  action :install
  package_name %w(libffi-dev bison automake libxml2-dev)
  only_if { platform?('ubuntu') }
end

# Users and Groups Stuff...
group node['php_chef']['group']

user_account 'vagrant' do
  shell '/usr/bin/zsh'
end

user node['php_chef']['user'] do
  action :create
  system true
  group node['php_chef']['group']
  shell '/usr/bin/zsh'
end

directory "/home/#{node['php_chef']['user']}/.rvm" do
  action :create
  owner node['php_chef']['user']
  group node['php_chef']['group']
  mode '0777'
  recursive true
end

group 'www-data' do
  action :create
  members ['vagrant', node['php_chef']['user']]
  append true
end

lxmx_oh_my_zsh_user node['php_chef']['user'] do
  plugins %w(git ruby rvm bower debian node npm tmux)
  home "/home/#{node['php_chef']['user']}"
  theme          'steeef'
  autocorrect    false
  case_sensitive true
end

lxmx_oh_my_zsh_user 'vagrant' do
  plugins        %w(git ruby rvm bower debian node npm tmux)
  home '/home/vagrant'
  theme          'steeef'
  autocorrect    false
  case_sensitive true
end

# Networking

hostsfile_entry '127.0.0.1' do
  hostname node['php_chef']['servername']
  action :append
end
