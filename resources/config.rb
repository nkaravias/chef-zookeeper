actions(:render)
default_action(:render)

attribute(:config, kind_of: Hash,   required: true)
attribute(:ensemble, kind_of: Array,   required: true)
attribute(:client_port, kind_of: String, default: '2181')
attribute(:quorum_port, kind_of: String, default: '2888')
attribute(:leader_port, kind_of: String, default: '3888')

attribute(:instance, kind_of: String, required: true )
attribute :service_name, :kind_of => String, default: 'zookeeper'

attribute(:config_path, kind_of: String, required:true )
attribute(:data_path, kind_of: String, required:true )
attribute(:install_path, kind_of: String, name_attribute: true)
attribute(:user, kind_of: String, default: 'zookeeper')
attribute(:group, kind_of: String, default: 'zookeeper')

