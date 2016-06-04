
default['php_chef']['user'] = 'deploy'
default['php_chef']['group'] = 'deploy'

# Web Server
default['php_chef']['appname'] = 'myapp'
default['php_chef']['servername'] = 'myapp.local'
default['php_chef']['document_root'] = "/var/www/#{node['php_chef']['appname']}"
default['php_chef']['webserver']['php_fpm_url'] = '/var/run/php5-fpm.sock'

# Database
default['mariadb']['install']['version'] = '5.5'
default['mariadb']['install']['prefer_os_package'] = false
default['mariadb']['apt_repository']['base_url'] = 'mirrors.digitalocean.com/mariadb/repo/'
default['php_chef']['database']['host'] = 'localhost'
default['php_chef']['database']['username'] = 'root'
default['php_chef']['database']['password'] = node['mariadb']['server_root_password']
default['php_chef']['database']['dbname'] = 'phpchef'

## PostgreSQL
default['postgresql']['pg_hba'] = [
  { type: 'local', db: 'all', user: 'postgres', addr: nil,            method: 'trust' },
  { type: 'local', db: 'all', user: 'all',      addr: nil,            method: 'trust' },
  { type: 'host',  db: 'all', user: 'all',      addr: '0.0.0.0/32',   method: 'md5'   },
  { type: 'host',  db: 'all', user: 'all',      addr: '127.0.0.1/32', method: 'trust' },
  { type: 'host',  db: 'all', user: 'all',      addr: '::1/128',      method: 'trust' }
]
default['postgresql']['initdb_locale'] = 'en_US.UTF8'
default['postgresql']['password']['postgres'] = 'postgres'

default['php_chef']['database']['app']['username'] = 'phpapp'
default['php_chef']['database']['app']['password'] = 'appsecret'

# Utilities
default['rvm']['user_installs'] = [
  {
    'user'          => 'vagrant',
    'default_ruby'  => '2.3.1',
    'rubies'        => ['2.3.1'],
    'global_gems' => [
      { 'name'    => 'bundler' },
      { 'name'    => 'rake' },
      { 'name'    => 'sass' },
      { 'name'    => 'capistrano' }
    ]
  }
]
