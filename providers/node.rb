Chef::Resource::RemoteFile.send(:include, Zookeeper::Zk_helper)
Chef::Resource::Execute.send(:include, Zookeeper::Zk_helper)
Chef::Resource::Link.send(:include, Zookeeper::Zk_helper)

use_inline_resources

def whyrun_supported?
   true
end

action :install do
  node_name = new_resource.name
  zk_archive = "zookeeper-#{new_resource.version}"
  zk_local_archive_path = ::File.join(Chef::Config[:file_cache_path], "#{zk_archive}.tar.gz")
  zk_install_root = ::File.expand_path('..', new_resource.install_path)

  group new_resource.group do
    action :create
    system true
  end

  user new_resource.user do
    home  new_resource.home
    shell  new_resource.shell
    gid  new_resource.group
    supports manage_home: false
    action  :create
    system true
  end

  download_package(zk_local_archive_path, new_resource.source_url)
  extract_package(zk_archive, zk_local_archive_path, zk_install_root)
  create_link(::File.join(zk_install_root, zk_archive), new_resource.install_path)
  [ new_resource.data_path, new_resource.log_path, new_resource.config_path ].each do |dir|
    create_directory(dir, new_resource.user, new_resource.group)
  end
end

def download_package(source, url)
  remote_file source do
    source url
    owner new_resource.user
    group new_resource.group
    mode '0644'
    not_if { zk_installed?(current_resource.install_path, current_resource.version) }
  end
end

def extract_package(name,source,destination)
  execute "Extract #{name} to #{destination}" do
    cwd destination
    command "tar zxvf #{source} -C .; chown #{new_resource.user}:#{new_resource.group} ./#{name}*"
    action :run
    not_if { zk_installed?(current_resource.install_path, current_resource.version) }
  end
end

def create_link(source,target)
  link target do
    to source
    owner new_resource.user
    group new_resource.group
    not_if { zk_installed?(current_resource.install_path ,current_resource.version) }
  end
end

def create_directory(path,zk_owner,zk_group)
  directory path do
    owner zk_owner
    group zk_group
    mode '0755'
    recursive true
    action :create
  end
end

def load_current_resource
  @current_resource = Chef::Resource::OmcZookeeperNode.new(@new_resource.name)
  @current_resource.user(@new_resource.user)
  @current_resource.group(@new_resource.group)
  @current_resource.shell(@new_resource.shell)
  @current_resource.home(@new_resource.home)
  @current_resource.source_url(@new_resource.source_url)
  @current_resource.version(@new_resource.version)
  @current_resource.install_path(@new_resource.install_path)
  @current_resource.data_path(@new_resource.data_path)
  @current_resource.log_path(@new_resource.log_path)
  @current_resource.config_path(@new_resource.config_path)
end
