name             'php_chef'
maintainer       'Pedro Tanaka'
maintainer_email 'me@pedrotanaka.com.br'
license          'Apache 2.0'
description      'Installs/Configures LEMP Stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


depends 'nginx', '~> 2.7.6'
depends 'vim', '~> 2.0.1'
depends 'zsh', '~> 2.0.0'
depends 'tmux', '~> 1.5.0'
depends 'lxmx_oh_my_zsh', '~> 0.5.0'
depends 'hostsfile', '~> 2.4.5'
depends 'mariadb', '~> 0.3.1'
