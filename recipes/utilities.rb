# Installs and configures rvm

include_recipe 'rvm::user'
include_recipe 'nodejs'
include_recipe 'nodejs::npm'
include_recipe 'composer'

nodejs_npm 'grunt'
nodejs_npm 'gulp'
nodejs_npm 'coffee-script'
nodejs_npm 'bower'
nodejs_npm 'yo'
