# -*- coding: utf-8 -*-

require 'spec_helper'

$node['omc_zookeeper'].tap do |zk|

  zk_usr = 'zookeeper'
  zk_grp = 'zookeeper'
  
 zk_dirs = {
  'data_path' => zk['data_path'],
  'log_path' => zk['log_path'],
  'install_path' => zk['install_path'],
  'config_path' => zk['config_path']
  }

  zk_files = {'zoo.cfg' => File.join(zk['install_path'],'conf','zoo.cfg'), 'initd' => '/etc/init.d/zookeeper', 'myid' => File.join(zk['data_path'],'myid')}

zk_dirs.each do |k,v|
  describe file(v) do
    it { should be_directory }
    it { should be_owned_by zk_usr }
    it { should be_grouped_into zk_grp }
  end
end

zk_files.each do |k,v|
  describe file(v) do
    it { should be_file }
    it { should be_owned_by zk_usr }
    it { should be_grouped_into zk_grp }
  end
end

describe service(zk['service_name']) do
  it { should be_enabled }
  it { should be_running }
end

[ zk['client_port'] ].each do |port|
  describe port(port) do
    it { should be_listening }
  end
end

end

=begin
zk_usr = 'zookeeper'
zk_grp = 'zookeeper'

describe user(zk_usr) do
  it { should belong_to_group zk_grp }
  it { should have_home_directory '/opt/zk_home' }
end

install_path = '/opt/zookeeper'
zk_dirs = {'config_path' => File.join(install_path,'conf'), 'data_path' => '/data/zookeeper/data', 'log_path' => '/var/log/zookeeper', 'pid_path' => '/var/run/zookeeper'}

zk_files = {'zoo.cfg' => File.join(install_path,'conf','zoo.cfg'), 'initd' => '/etc/init.d/zookeeper', 'myid' => '/data/zookeeper/data/myid'}

zk_dirs.each do |k,v|
  describe file(v) do
    it { should be_directory }
    it { should be_owned_by zk_usr }
    it { should be_grouped_into zk_grp }
  end
end

zk_files.each do |k,v|
  describe file(v) do
    it { should be_file }
    it { should be_owned_by zk_usr }
    it { should be_grouped_into zk_grp }
  end
end

describe service('zookeeper') do
  it { should be_enabled }
  it { should be_running }
end

[ 2181 ].each do |port|
  describe port(port) do
    it { should be_listening }
  end
end
=end
