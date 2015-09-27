# -*- coding: utf-8 -*-
#
# Cookbook Name:: zookeeper
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#

#node.set[:java][:install_flavor]='oracle'
#node.set[:java][:jdk_version]='8'
#node.set[:java][:oracle][:accept_oracle_download_terms]=true

include_recipe 'java'

omc_zookeeper_node 'zookeeper' do
  user 'zookeeper'
  group 'zookeeper'
  source_url 'http://www.us.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz'
  install_path '/opt/zookeeper'
  version '3.4.6'
  data_path '/scratch/zookeeper/data'
  log_path '/var/log/zookeeper'
  config_path '/opt/zookeeper/conf'
  action [:install, :configure]
end

omc_zookeeper_config ::File.join('/opt/zookeeper/conf', 'zoo.cfg') do
  ensemble ['default-oel65-chef-java']
  instance node.hostname.downcase
  config 'clientPort' => '2181', 'initLimit' => '10', 'syncLimit' => '5', 'tickTime' => '2000'
  client_port '2181'
  quorum_port '2888'
  leader_port '3888'
  config_path '/opt/zookeeper/conf'
  data_path '/scratch/zookeeper/data'
  user 'zookeeper'
  action :render
end
