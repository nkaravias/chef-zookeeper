# -*- coding: utf-8 -*-
#
# Cookbook Name:: zookeeper
# Attributes:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
default[:java][:install_flavor] = 'oracle'
default[:java][:jdk_version] = '8'
default[:java][:oracle][:accept_oracle_download_terms] = true

=begin
default[:omc_zookeeper].tap do |zk|
  zk[:config][:ensemble] = ['']
  zk[:config][:client_port] = '2181'
  zk[:config][:leader_port] = '3888'
  zk[:config][:quorum_port] = '2888'
  zk[:config][:properties][:clientPort] = '2181'
  zk[:config][:properties][:initLimit] = '10'
  zk[:config][:properties][:syncLimit] = '5'
  zk[:config][:properties][:tickTime] = '2000'
  zk[:package][:dir_conf] = '/opt/zookeeper/conf'
  zk[:package][:dir_data] = '/scratch/zookeeper/data'
  zk[:package][:install_path] = '/opt/zookeeper'
  zk[:package][:source_url] = 'http://www.us.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz'
  zk[:package][:version] = '3.4.6'
  zk[:user][:username] = 'zookeeper'
  zk[:user][:group] = 'zookeeper'
  zk[:user][:home] = '/opt/zk_home'
  zk[:user][:shell] = '/bin/bash'
end
=end
