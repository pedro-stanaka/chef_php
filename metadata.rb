name             'php_chef'
maintainer       'Pedro Tanaka'
maintainer_email 'me@pedrotanaka.com.br'
license          'Apache 2.0'
description      'Installs/Configures LEMP Stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/pedro-stanaka/php_chef'
issues_url       'https://github.com/pedro-stanaka/php_chef/issues'
version          '0.1.0'

# WebServer
depends 'user', '~> 0.4.2'
depends 'php', '~> 1.9.0'
depends 'nginx', '~> 2.7.6'

# Database
depends 'database', '~> 5.1.2'
depends 'mysql2_chef_gem', '= 0.1.0'
depends 'postgresql', '~> 4.0.6'
depends 'mariadb', '~> 0.3.1'

# Utilities
depends 'vim', '~> 2.0.1'
depends 'htop', '~> 2.0.0'
depends 'git', '~> 4.5.0'
depends 'curl'
depends 'zlib'
depends 'zsh', '~> 2.0.0'
depends 'lxmx_oh_my_zsh', '~> 0.5.0'
depends 'tmux', '~> 1.5.0'
depends 'rvm', '~> 0.9.4'
depends 'hostsfile', '~> 2.4.5'
depends 'nodejs', '~> 2.4.4'
depends 'composer', '~> 2.3.0'
