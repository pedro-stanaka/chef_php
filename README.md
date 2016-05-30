# rpdevel-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rpdevel']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### rpdevel::default

Include `rpdevel` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[rpdevel::default]"
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
