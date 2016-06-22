
include_recipe 'mariadb::server'
include_recipe 'mariadb::client'

include_recipe 'postgresql::client'

directory "/etc/postgresql/#{node['postgresql']['version']}/main" do
  owner 'nobody'
  group 'nogroup'
  mode 00755
  recursive true
  action :create
  only_if { platform?('ubuntu') }
end

include_recipe 'postgresql::server'
include_recipe 'postgresql::config_initdb'

if platform?('debian') || (platform?('ubuntu') && node['platform_version'].to_f > 14.04)
  node['php_chef']['database']['packages'].each do |pkg|
    package 'Debian MariaDB Client Files' do
      action :install
      package_name pkg
    end
  end

  template '/tmp/mysql_fix.sql' do
    source 'fix_maria_socket_auth.sql.erb'
    mode 00777
  end

  execute 'fix mysql socket auth' do
    command "sudo mysql -uroot -p#{node['mariadb']['server_root_password']} < /tmp/mysql_fix.sql"
    action :run
  end
end

# Include after installing client libraries
include_recipe 'mysql2_chef_gem::mariadb'

mysql_database node['php_chef']['database']['dbname'] do
  connection(
    host: node['php_chef']['database']['host'],
    username: node['php_chef']['database']['username'],
    password: node['php_chef']['database']['password']
  )
end

mysql_database_user node['php_chef']['database']['app']['username'] do
  connection(
    host: node['php_chef']['database']['host'],
    username: node['php_chef']['database']['username'],
    password: node['php_chef']['database']['password']
  )
  password node['php_chef']['database']['app']['password']
  database_name node['php_chef']['database']['dbname']
  host node['php_chef']['database']['host']
  action [:create, :grant]
end
