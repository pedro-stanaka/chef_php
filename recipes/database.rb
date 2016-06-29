
include_recipe 'mariadb::server'
include_recipe 'mariadb::client'

directory "/etc/postgresql/#{node['postgresql']['version']}/main" do
  owner 'nobody'
  group 'nogroup'
  mode 0o0755
  recursive true
  action :create
  only_if { platform?('ubuntu') }
end

if platform?('debian') || (platform?('ubuntu') && node['platform_version'].to_f > 14.04)
  node['php_chef']['database']['packages'].each do |pkg|
    package 'Debian MariaDB Client Files' do
      action :install
      package_name pkg
    end
  end
end

# Include after installing client libraries
include_recipe 'mysql2_chef_gem::mariadb'

mysql_connection = {
  host: node['php_chef']['database']['host'],
  username: node['php_chef']['database']['username'],
  password: (node['php_chef']['database']['password'] if (platform?('ubuntu')
    && node['platform_version'].to_f <= 14.04)),
  socket: '/var/run/mysqld/mysqld.sock'
}.reject{ |k,v| v.nil? }

mysql_database node['php_chef']['database']['dbname'] do
  connection(mysql_connection)
end

mysql_database_user node['php_chef']['database']['app']['username'] do
  connection({
    host: node['php_chef']['database']['host'],
    username: node['php_chef']['database']['username'],
    password: if (platform?('ubuntu') && node['platform_version'].to_f <= 14.04)
      node['php_chef']['database']['password'] else nil,
    socket: '/var/run/mysqld/mysqld.sock'
  }
  )
  password node['php_chef']['database']['app']['password']
  database_name node['php_chef']['database']['dbname']
  host node['php_chef']['database']['host']
  action [:create, :grant]
end

## PostgreSQL

include_recipe 'postgresql::client'
include_recipe 'postgresql::server'
include_recipe 'postgresql::config_initdb'
