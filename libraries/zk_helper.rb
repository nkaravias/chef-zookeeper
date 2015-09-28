#include Chef::Mixin::ShellOut

module Zookeeper
  module Zk_helper
    def zk_installed?(path, version)
      zk_flag = ::File.join(path, "zookeeper-#{version}.jar")
      ::File.exist?(zk_flag)
    end
    
    # ensemble is an array of hashes [{ id: '', hostname: '', status: ''}]
    # instance is the local hostname on which Chef is running
    def get_zk_id(ensemble, instance)
      #ensemble.index(instance).next.to_s
      if host = ensemble.find { |n| n['hostname'] == instance }
        return host['id']
      else 
        raise "Unable to find zookeeper id for ensemble hosts:#{ensemble} and hostname: #{instance}"
      end
    end

    def render(hash,key,separator=': ',prefix='',suffix='')
      value = hash[key]
      unless value.nil?
        if value.is_a?(Array)
          return [prefix,key,separator,value.to_s,suffix,"\n"].join
        else
          return [prefix,key,separator,value.to_s,suffix,"\n"].join
        end
        return nil
      end
    end

  end
end
