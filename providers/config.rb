include Zookeeper::Zk_helper

use_inline_resources

def whyrun_supported?
  true
end

action :render do

  service new_resource.service_name do
    supports :restart => true, :start => true, :stop => true, :reload => true
    action :nothing
  end

  config_path = new_resource.config_path
  data_path = new_resource.data_path
  client_port = new_resource.client_port
  quorum_port = new_resource.quorum_port
  leader_port = new_resource.leader_port

  ensemble_data_bag = new_resource.ensemble_data_bag_info.keys.first
  ensemble = data_bag_item(ensemble_data_bag, new_resource.ensemble_data_bag_info[ensemble_data_bag])

  active_ensemble = ensemble['hosts'].reject { |c| c['status'] != 'ACTIVE' }
  # Add a check: parse the databag - if there's duplicate active hosts - raise an exception
  servers = active_ensemble.inject({}) {|hash, host| hash["server.#{host['id']}"] = "#{host['hostname'] == new_resource.instance ? '0.0.0.0' : host['hostname']}:#{quorum_port}:#{leader_port}"; hash}
  zk_id =  get_zk_id(active_ensemble, new_resource.instance).to_s

  file "Zookeeper config for #{data_path}/myid" do
    path ::File.join(data_path, 'myid')
    owner new_resource.user
    group new_resource.group
    mode '0755'
    content(zk_id) 
  end

  # Merge configuration with overriden values
  default_config= new_resource.default_config.merge(new_resource.override_config)
  default_config['dataDir']= new_resource.data_path
  default_config['clientPort']= new_resource.client_port
  default_config['quorumPort']= new_resource.quorum_port
  default_config['leaderPort']= new_resource.leader_port
  default_config.merge!(servers)
  ### + Check if mandatory attributes are not overriden...   
  
  template "Zookeeper config for #{config_path}/zoo.cfg" do
    path ::File.join(config_path, 'zoo.cfg')
    source 'config/zoo.cfg.erb'
    owner new_resource.user
    group new_resource.group
    cookbook "omc_zookeeper"
    helpers(Zookeeper::Zk_helper)
    mode '0755'
    variables( :config => default_config)
    notifies :restart, "service[#{new_resource.service_name}]"
  end

  template "Init.d script for #{new_resource.service_name}" do
    path "/etc/init.d/#{new_resource.service_name}"
    source 'init/zookeeper.erb'
    owner new_resource.user
    group new_resource.group
    mode '0755'
    cookbook 'omc_zookeeper'
    notifies :enable, "service[#{new_resource.service_name}]"
    notifies :start, "service[#{new_resource.service_name}]"
    variables( :install_dir => new_resource.install_path, :data_dir => new_resource.data_path, :log_dir => new_resource.log_path, :config_dir => new_resource.config_path, :user => new_resource.user)
  end

  new_resource.updated_by_last_action(true)
end

def load_current_resource
  @current_resource = Chef::Resource::OmcZookeeperConfig.new(@new_resource.name)
  @current_resource.service_name(@new_resource.service_name)
  @current_resource.user(@new_resource.user)
  @current_resource.group(@new_resource.group)
  @current_resource.client_port(@new_resource.client_port)
  @current_resource.quorum_port(@new_resource.quorum_port)
  @current_resource.leader_port(@new_resource.leader_port)
  @current_resource.config_path(@new_resource.config_path)
  @current_resource.data_path(@new_resource.data_path)
  @current_resource.log_path(@new_resource.log_path)
  @current_resource.install_path(@new_resource.install_path)
  @current_resource.ensemble_data_bag_info(@new_resource.ensemble_data_bag_info)
  @current_resource.instance(@new_resource.instance)
  @current_resource.default_config(@new_resource.default_config)
  @current_resource.override_config(@new_resource.override_config)
end
