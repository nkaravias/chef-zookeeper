#include Chef::Mixin::ShellOut

module Zookeeper
  module Zk_helper
    def zk_installed?(path, version)
      zk_flag = ::File.join(path, "zookeeper-#{version}.jar")
      ::File.exist?(zk_flag)
    end

    def get_zk_id(ensemble, instance)
      ensemble.index(instance).next.to_s
    end
  end
end
