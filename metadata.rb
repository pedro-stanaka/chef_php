name             'php_chef'
maintainer       'Pedro Tanaka'
maintainer_email 'pedro.stanaka@gmail.com'
license          'All rights reserved'
description      'Installs/Configures LEMP Stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'



depends 'nginx', '~> 2.7.6'
depends 'vim', '~> 2.0.1'
depends 'zsh', '~> 2.0.0'
depends 'lxmx_oh_my_zsh', '~> 0.5.0'