# OMC zookeeper Cookbook

Exposes two LWRPs for installing and configuring a zookeeper node (omc_zookeeper_node & omc_zookeeper_config).

## Requirements

This coobook requires Java and uses the relevant cookbook to install it. The dependency is defined in the Berksfile & metadata.rb

#Data bags:
* All zookeeper nodes much get added to the data bag item that gets passed to the omc_kafka_config resource as the ensemble_data_bag_info hash attribute. The data bag item should look like this:
```json
{
 "id": "zookeeper_localdev",
 "environment": "localdev",
 "use": "slapchop",
 "hosts": [{ "id": 1, "hostname": "default-oel65-chef-java", "status": "ACTIVE" },{ "id":2, "hostname": "test02" , "status": "DECOMISSIONED" },{ "id":3, "hostname": "test03" , "status": "DECOMISSIONED" }]
}
```
Short breakdown of the hosts hash contents and usage:
<table>
  <tr>
    <th>Key</th>
    <th>Value description</th>
  </tr>
  <tr>
    <td>id</td>
    <td>The zookeeper node id (0-255) should be used and be considered immutable. This value cannot be reused in an active ensemble</td>
  </tr>
  <tr>
    <td>hostname</td>
    <td>The FQDN of the zookeeper node</td>
  </tr>  
  <tr>
    <td>Status</td>
    <td>The state of the zookeeper node. If it is a member of a live ensemble then the value should be ACTIVE. In any other case set to any string but ACTIVE, e.g DECOMISSIONED, INVALID. When adding a net new node you should never be using the same myid</td>
  </tr>  
</table>

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

1. Create a named feature branch (adding any relevant Jira ID as a prefix is the recommended approach)
2. Write your change
3. Write tests for your change (Unit / Integration if applicable)
4. Run the tests, ensuring they all pass
5. Submit a Pull Request
