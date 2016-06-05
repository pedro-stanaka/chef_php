
# TODO: manage packages depending on version of OS (make compatible with ubuntu 16.04)
package 'Install ICU Libs (development)' do
  action :install
  package_name default['php_chef']['webserver']['php_extensions']
end
