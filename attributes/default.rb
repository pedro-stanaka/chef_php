
default['php_chef']['user'] = 'deploy'
default['php_chef']['group'] = 'deploy'

default['php_chef']['appname'] = 'myapp'
default['php_chef']['servername'] = 'myapp.local'
default['php_chef']['document_root'] = "/var/www/#{node['php_chef']['appname']}"
