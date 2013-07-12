#apt update
execute "apt-get update" do
  command "apt-get update"
  action :run
end

#install java
package "openjdk-7-jre-headless" do
  action :install
end

#configure firewall rules to open a port for elasticsearch
ruby_block "edit iptables.rules" do
  block do
    es_port_rule = "-A TCP -p tcp -m tcp --dport #{node[:elasticsearch][:port]} -j ACCEPT"
    es_cluster_port_rule = "-A TCP -p tcp -m tcp --dport #{node[:elasticsearch][:cluster_port]} -j ACCEPT"

    ip_rules = Chef::Util::FileEdit.new('/etc/iptables.rules')
    ip_rules.insert_line_after_match('^## TCP$', es_port_rule)
    ip_rules.insert_line_after_match('^## TCP$', es_cluster_port_rule)
    ip_rules.write_file
  end
end

#apply new firewall rules immediately
bash "iptables-restore" do
  user "root"
  code <<-EOH
    iptables-restore /etc/iptables.rules
  EOH
  action :run
end

# Run a bash shell -  download, install and run ES
bash "install elasticsearch" do
     user "root"
     cwd "/tmp/"
     code <<-EOH
       wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.0.deb
       sudo dpkg -i elasticsearch-0.90.0.deb
     sudo service elasticsearch start
     EOH
end

#elasticsearch service
service "elasticsearch" do
  supports :restart => true, :start => true, :stop => true, :status => true
end

#installs elasticsearch head
execute "install head plugin" do
  command "sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head"
  action :run
end


#searching for existing nodes in replset, only possible with Chef Server, not with Chef Solo
if Chef::Config[:solo]
  Chef::Log.warn("This recipe requires Chef Server to join replsets. This node will start as cluster")
  db_nodes = []
  db_ip = []
else
  db_nodes = search(:node, "elasticsearch_cluster_name:#{node[:elasticsearch][:cluster_name]}")
  db_ip = []
  db_nodes.each do |db_node|
    if db_node[:is_master]
      db_ip.push(db_node[:ipaddress])
    end
  end
end

# if first node of cluster do default configuration
if db_nodes.empty?

  node.set[:is_master] = "true"

  #mod config file 
  template "/etc/elasticsearch/elasticsearch.yml" do
    source "elasticsearch.yml.erb"
    variables(
      :cluster_name => node[:elasticsearch][:cluster_name],
      :node_name => node[:fqdn], 
      :master_name => node[:fqdn]
    )
    notifies :restart, resources(:service => "elasticsearch")
  end

  #mod hosts file
  template "/etc/hosts" do
    source "hosts.erb"
    variables(
      :master_ip => node[:ipaddress],
      :master_name => node[:fqdn]
    )
  end
else 
  #todo iterate through nodes to get master node(s)
end


