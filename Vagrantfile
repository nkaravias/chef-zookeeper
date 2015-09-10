# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

# -*- mode: ruby -*-

# vi: set ft=ruby :

boxes = [
    {
        :name => "zk01",
        :mem => "2048",
        :cpu => "2",
    }
]

Vagrant.configure(2) do |config|

  config.vm.provider :virtualbox do |v, override|
    config.vm.box = "oel65-fixed"
    #config.vm.box_url = "http://den00aef.us.oracle.com/oel-65-slapchop.box"
  end

  #config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", nfs: true

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]

      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end

      config.vm.network "forwarded_port", guest: 9200, host: 9200
      config.vm.network "forwarded_port", guest: 9201, host: 9201       
      config.vm.network "forwarded_port", guest: 9202, host: 9202              
      config.vm.network "forwarded_port", guest: 9300, host: 9300       
      config.vm.network "forwarded_port", guest: 7654, host: 7654
      config.vm.network "forwarded_port", guest: 2181, host: 2181
      config.vm.network "forwarded_port", guest: 9092, host: 9092    
 
      config.timezone.value = "America/Toronto"
      config.proxy.http     = "http://www-proxy.us.oracle.com:80"
      config.proxy.https    = "http://www-proxy.us.oracle.com:80"
      config.proxy.no_proxy = "localhost,127.0.0.1"

      config.hostmanager.enabled = true
      config.hostmanager.manage_host = true
      config.hostmanager.ignore_private_ip = false
      config.hostmanager.include_offline = false
      #config.vm.provision "shell", path: "scripts/salt_provision.sh"
      #config.vm.provision "shell", path: "scripts/kafka_topics.sh"
      #config.vm.provision "shell", path: "scripts/setup_slapchop.sh"

      #config.vm.provision :serverspec do |spec|
      #  spec.pattern = '*_spec.rb'
      #end
    end
  end
end
