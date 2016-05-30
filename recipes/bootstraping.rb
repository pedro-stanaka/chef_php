
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
  hostname node['php_chef']['servername']
  action :append
end

