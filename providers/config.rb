include Zookeeper::Zk_helper

use_inline_resources

def whyrun_supported?
  true
end

action :render do
  ensemble = new_resource.ensemble
  instance = new_resource.instance
  config_path = new_resource.config_path
  data_path = new_resource.data_path
  client_port = new_resource.client_port
  quorum_port = new_resource.quorum_port
  leader_port = new_resource.leader_port

  servers = ensemble.map { |n| "server.#{ensemble.index(n).next}:#{n == instance ? '0.0.0.0' : n}:#{quorum_port}:#{leader_port}" }
  zk_content =  { 'dataDir' => data_path,
 'clientPort' => client_port }.merge(new_resource.config).map { |kv| kv.join('=') }.concat(servers).join("\n")
  zk_id =  get_zk_id(ensemble, instance)
  
  service new_resource.service_name do
    action :nothing
  end

  file "Zookeeper config for #{data_path}/myid" do
    path ::File.join(data_path, 'myid')
    owner new_resource.user
    group new_resource.group
    mode '0755'
    content(zk_id) 
  end

  template "Zookeeper config for #{config_path}/zoo.cfg" do
    path ::File.join(config_path, 'zoo.cfg')
    source 'config/zoo.cfg.erb'
    owner new_resource.user
    group new_resource.group
    cookbook "omc_zookeeper"
    mode '0755'
    variables( :config => zk_content)
    notifies :restart, "service[#{new_resource.service_name}]"
  end
end
