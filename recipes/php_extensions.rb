
# TODO: manage packages depending on version of OS (make compatible with ubuntu 16.04)
package 'Install ICU Libs (development)' do
  action :install
  package_name node['php_chef']['webserver']['php_extensions']
  notifies :restart, 'service[nginx]'
end
