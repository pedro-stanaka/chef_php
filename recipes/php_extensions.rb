
# TODO: manage packages depending on version of OS (make compatible with ubuntu 16.04)
package 'Install ICU Libs (development)' do
  action :install
  case node['platform']
  when 'redhat', 'centos', 'amazon', 'scientific', 'oracle'
    package_name %w(libicu-devel php-mysql php-pgsql)
  when 'ubuntu', 'debian'
    package_name %w(libicu-dev php5-mysql php5-pgsql)
  end
end
