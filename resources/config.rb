actions(:render)
default_action(:render)

attribute(:ensemble_data_bag_info, kind_of: Hash,   required: true)
attribute(:client_port, kind_of: Integer, default: 2181)
attribute(:quorum_port, kind_of: Integer, default: 2888)
attribute(:leader_port, kind_of: Integer, default: 3888)

attribute(:instance, kind_of: String, default: 'zookeeper')
attribute :service_name, :kind_of => String, default: 'zookeeper'


attribute :data_path, :kind_of => String, default: '/scratch/zookeeper/data'
attribute :log_path, :kind_of =>  String, default: '/var/log/zookeeper'
attribute :config_path, :kind_of => String, default: '/opt/zookeeper/conf'
attribute(:install_path, kind_of: String, default: '/opt/zookeeper')
attribute(:user, kind_of: String, default: 'zookeeper')
attribute(:group, kind_of: String, default: 'zookeeper')

### General configuration attributes for zookeeper
# Default
attribute(:default_config, kind_of: Hash, default: {
  'tickTime' => 2000,
  'initLimit' => 10,
  'syncLimit' => 5
})
# Override
attribute(:override_config, kind_of: Hash, default: {})
attribute :java_opts, kind_of: String, default: '-Xms256M -Xmx512M'
