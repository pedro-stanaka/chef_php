# Control variables
# dev, deploy
default['php_chef']['environment'] = 'dev'

# Users and groups
default['php_chef']['user'] = 'deploy'
default['php_chef']['group'] = 'deploy'

# Web Server
default['php_chef']['appname'] = 'myapp'
default['php_chef']['servername'] = 'myapp.local'
default['php_chef']['document_root'] = "/var/www/#{node['php_chef']['appname']}"
default['php_chef']['webserver']['php_fpm_url'] = '/var/run/php-fpm.sock'

default['php_chef']['database']['host'] = 'localhost'
default['php_chef']['database']['username'] = 'root'
default['php_chef']['database']['password'] = node['mariadb']['server_root_password']
default['php_chef']['database']['dbname'] = 'phpchef'
default['php_chef']['database']['app']['username'] = 'phpapp'
default['php_chef']['database']['app']['password'] = 'appsecret'

php_packages = []

default['php_chef']['webserver']['redis_version'] = '2.2.8'
case node['platform_family']
when 'rhel', 'fedora' # (redhat, centos, scientific, etc)
  php_packages = %w(php-mysql php-pgsql php-intl)
when 'debian'
  php_packages = %w(libicu-dev php5-mysql php5-pgsql php5-intl)

  if platform?('ubuntu')
    case node['platform_version'].to_f
    when 16.04
      php_packages = node['php']['src_deps'] + \
                     %w(libicu-dev php7.0-mysql php7.0-pgsql php-intl php-mbstring)
      default['php_chef']['webserver']['redis_version'] = '3.0.0'
    end
  end
end

default['php_chef']['webserver']['php_extensions'] = php_packages

# Database
default['mariadb']['install']['version'] = '10.0'
case node['platform']
when 'ubuntu'
  default['mariadb']['install']['version'] = '5.5'
  case node['platform_version'].to_f
  when 16.04
    default['mariadb']['install']['version'] = '10.0'
    default['mariadb']['client']['development_files'] = false
    default['php_chef']['database']['packages'] = \
      %w(libmariadb-client-lgpl-dev libmariadbd-dev libmysqlclient-dev)
  end
when 'debian'
  default['mariadb']['client']['development_files'] = false
  default['php_chef']['database']['packages'] = \
    %w(libmariadb-client-lgpl-dev libmariadbd-dev)
end

case node['platform_family']
when 'rhel', 'fedora'
  default['mariadb']['install']['prefer_os_package'] = true
when 'debian'
  default['mariadb']['apt_repository']['base_url'] = 'mirrors.digitalocean.com/mariadb/repo/'
  default['mariadb']['install']['prefer_os_package'] = false
end

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

if platform?('ubuntu') && node['platform_version'].to_f > 14.04
  # Ubuntu Xenial
  default['postgresql']['version'] = '9.5'
  default['postgresql']['dir'] = '/etc/postgresql/9.5/main'
  default['postgresql']['client']['packages'] = ['postgresql-client-9.5', 'libpq-dev']
  default['postgresql']['server']['packages'] = ['postgresql-9.4']
  default['postgresql']['contrib']['packages'] = ['postgresql-contrib-9.4']
end

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

if platform?('ubuntu') && node['platform_version'].to_f > 14.04
  default['nodejs']['packages'] = ['nodejs', 'npm', 'nodejs-dev']
end
