actions :install
default_action :install

attribute :user, :kind_of => String, default: 'zookeeper'
attribute :group, :kind_of => String, default: 'zookeeper'
attribute :shell, kind_of: String, default: '/bin/bash'
attribute :home, :kind_of => String, default: '/opt/zk_home'

attribute :source_url, :kind_of => String, default: 'http://www.us.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz'
attribute :version, kind_of: String, default: '3.4.6'
attribute :install_path, :kind_of => String, default: '/opt/zookeeper'
#attribute :service_name, kind_of: 'String', default: 'zookeeper'

attribute :data_path, :kind_of => String, default: '/scratch/zookeeper/data'
attribute :log_path, :kind_of =>  String, default: '/var/log/zookeeper'
attribute :config_path, :kind_of => String, default: '/opt/zookeeper/conf'
