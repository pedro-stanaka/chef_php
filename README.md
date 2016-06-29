# php_chef Cookbook
[![Build Status](https://travis-ci.org/pedro-stanaka/php_chef.svg?branch=master)](https://travis-ci.org/pedro-stanaka/php_chef)

This cookbook installs/configures the following packages:

* PHP7
* NGINX
* MySQL (MariaDB)
* PostgreSQL (9.4)
* NodeJS + NPM
  * Grunt
  * Gulp
  * CoffeeScript
  * Bower
  * Yo

## Quick start

If you want to use this cookbok as entry point for a Vagrant box. Check out my box:
[CakeOven](https://atlas.hashicorp.com/pedrostanaka/boxes/cake-oven).

It is just as easy as running ```vagrant up```

## Supported platforms

This cookbook shoul work on Ubuntu (14.04+), Debian (7+) and CentOS (7.2+).
But was tested against Ubuntu 14.04, Ubuntu 16.04 and Debian 8;

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['php_chef']['appname']</tt></td>
    <td>string</td>
    <td>Default app name</td>
    <td><tt>mypp</tt></td>
  </tr>
  <tr>
    <td><tt>['php_chef']['servername']</tt></td>
    <td>string</td>
    <td>Default hostname</td>
    <td><tt>myapp.local</tt></td>
  </tr>
  <tr>
    <td><tt>['php_chef']['webserver']['php_fpm_url']</tt></td>
    <td>string</td>
    <td>Default URL used by NGINX to connect on PHP-FPM</td>
    <td><tt>/var/run/php-fpm.sock</tt></td>
  </tr>
  <tr>
    <td><tt>['php_chef']['database']['dbname']</tt></td>
    <td>string</td>
    <td>Name of the database for the application</td>
    <td><tt>phpchef</tt></td>
  </tr>
  <tr>
    <td><tt>['php_chef']['database']['app']['username']</tt></td>
    <td>string</td>
    <td>The user for the application</td>
    <td><tt>phpapp</tt></td>
  </tr>
  <tr>
    <td><tt>['php_chef']['database']['app']['password']</tt></td>
    <td>string</td>
    <td>password of the user</td>
    <td><tt>appsecret</tt></td>
  </tr>
</table>


## Usage

### php_chef::default

Include `php_chef` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[php_chef::default]"
  ]
}
```

### Deploy in server

1. Install [ChefDK](https://downloads.chef.io/chef-dk/)
2. Clone the repo in a folder ```~/recipes/php_chef```
3. Run ```berks install``` inside the root of the repo you just cloned ```~/recipes/php_chef```
4. Install your recipes with ```berks vendor -b ~/recipes/php_chef/Berksfile```
5. Rename the ```berks-cookbooks``` directory to ```cookbooks``` (i.e. ```mv berks-cookbooks cookbooks```)
6. Run chef-client in local-mode ```sudo chef-client -o php_chef -z ```
(sudo is necessary in order to install all the packages)
7. Profit!!!!


## License and Authors

Author:: Pedro Tanaka (me@pedrotanaka.com.br)
