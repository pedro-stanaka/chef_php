
include_recipe 'mariadb::server'
include_recipe 'mariadb::client'
include_recipe 'mysql2_chef_gem::mariadb'


mysql_database node['php_chef']['database']['dbname'] do
  connection(
    :host => node['php_chef']['database']['host'],
    :username => node['php_chef']['database']['username'],
    :password => node['php_chef']['database']['password']
  )
end
