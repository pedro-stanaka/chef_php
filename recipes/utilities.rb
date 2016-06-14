# Installs and configures rvm

include_recipe 'rvm::user'
include_recipe 'nodejs::nodejs'
include_recipe 'nodejs::npm'
include_recipe 'composer'

execute 'node old executable linking' do
  command 'sudo ln -s /usr/bin/nodejs /usr/bin/node'
  only_if { platform_family?('debian') }
end

nodejs_npm 'grunt'
nodejs_npm 'gulp'
nodejs_npm 'coffee-script'
nodejs_npm 'bower'
nodejs_npm 'yo'
