# OMC zookeeper Cookbook

Exposes two LWRPs for installing and configuring a zookeeper node (omc_zookeeper_node & omc_zookeeper_config).

## Requirements

This coobook requires Java and uses the relevant cookbook to install it. The dependency is defined in the Berksfile & metadata.rb

## Attributes

[:config][:ensemble] = [] # csv list of hostnames that are part of the zookeeper ensemble\n
[:config][:client_port] = '2181' # Zookeeper client port\n
[:config][:leader_port] = '3888' # Zookeeper leader election port\n
[:config][:quorum_port] = '2888' # Zookeeper quorum port\n

All items of the properties object will get passed to zoo.cfg. If there's any additional configuration that needs to get added there then simply add a new property key:value pair
[:config][:properties][:clientPort] = '2181'\n
[:config][:properties][:initLimit] = '10'\n
[:config][:properties][:syncLimit] = '5'\n
[:config][:properties][:tickTime] = '2000'

[:package][:dir_conf] = '/opt/zookeeper/conf' # Zookeeper config path\n
[:package][:dir_data] = '/scratch/zookeeper/data' # Zookeeper data path\n
[:package][:install_path] = '/opt/zookeeper' # Zookeeper home directory\n
[:package][:source_url] = 'http://www.us.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz' # Zookeeper archive url\n
[:package][:version] = '3.4.6' # Zookeeper version

[:user][:username] = 'zookeeper' # Zookeeper user / group / home directory and shell\n
[:user][:group] = 'zookeeper'\n
[:user][:home] = '/opt/zk_home'\n
[:user][:shell] = '/bin/bash'


#### (LWRP) omc_zookeeper_node
<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>user</tt></td>
    <td>zookeeper</td>
    <td>User under which the zookeeper service will be running as</td>
    <td><tt>zookeeper</tt></td>
  </tr>
  <tr>
    <td><tt>group</tt></td>
    <td>zookeeper</td>
    <td>Group of users that own zookeeper</td>
    <td><tt>zookeeper</tt></td>
  </tr>
  <tr>
    <td><tt>source_url</tt></td>
    <td>String</td>
    <td>Group of users that own zookeeper</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>install_path</tt></td>
    <td>String</td>
    <td>Zookeeper installation path</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>version</tt></td>
    <td>String</td>
    <td>Zookeeper package version</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>data_path</tt></td>
    <td>String</td>
    <td>Zookeeper data path</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>log_path</tt></td>
    <td>String</td>
    <td>Zookeeper log path</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>config_path</tt></td>
    <td>String</td>
    <td>Zookeeper config path</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>action</tt></td>
    <td>Symbol</td>
    <td>Resource actions (:install || :configure)</td>
    <td><tt>:install</tt></td>
  </tr>
</table>

#### (LWRP) omc_zookeeper_config
<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>user</tt></td>
    <td>zookeeper</td>
    <td>User under which the zookeeper service will be running as</td>
    <td><tt>zookeeper</tt></td>
  </tr>
</table>

## Usage

#### (LWRP) omc_zookeeper_config
TODO: Write usage instructions for each cookbook.

e.g.
Just include `zookeeper` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[zookeeper]"
  ]
}
```

## Contributing

TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: TODO: List authors
