
include_recipe 'mariadb::server'
include_recipe 'mariadb::client'

directory "/etc/postgresql/#{node['postgresql']['version']}/main" do
  owner 'nobody'
  group 'nogroup'
  mode 00755
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

  template '/tmp/mysql_bootstrap.sql' do
    source 'create_database_and_user.sql.erb'
    mode 00777
  end

  execute 'create user and database' do
    command <<-eos
            sudo mysql -u#{node['php_chef']['database']['username']} \
              -p#{node['mariadb']['server_root_password']} < /tmp/mysql_bootstrap.sql
            eos
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
  only_if { (platform?('ubuntu') && node['platform_version'].to_f <= 14.04)  }
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
  only_if { (platform?('ubuntu') && node['platform_version'].to_f <= 14.04)  }
end


## PostgreSQL

include_recipe 'postgresql::client'
include_recipe 'postgresql::server'
include_recipe 'postgresql::config_initdb'
