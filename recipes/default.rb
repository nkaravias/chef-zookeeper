# -*- coding: utf-8 -*-
#
# Cookbook Name:: zookeeper
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
include_recipe 'java'

omc_zookeeper_node 'zookeeper' do
 # user 'zookeeper'
 # group 'group'
 # shell '/bin/bash'
  home '/opt/zk_home'
  source_url 'http://www.us.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz'
  version '3.4.6'
  install_path '/opt/zookeeper'
  data_path '/data/zookeeper/data'
  log_path '/var/log/zookeeper'
  config_path '/opt/zookeeper/conf'
  action :install
end

omc_zookeeper_config ::File.join('/opt/zookeeper/conf', 'zoo.cfg') do
  ensemble_data_bag_info 'slapchop' => 'zookeeper_localdev'
  client_port 2181
  quorum_port 2888
  leader_port 3888
  instance node['fqdn'].downcase
  service_name 'zookeeper'
  install_path '/opt/zookeeper'
  data_path '/data/zookeeper/data'
  log_path '/var/log/zookeeper'
  config_path '/opt/zookeeper/conf'
 # user 'zookeeper'
 # group 'group'
 # default_config node[:omc_zookeeper][:default_config]
  override_config {}
  action :render
end
