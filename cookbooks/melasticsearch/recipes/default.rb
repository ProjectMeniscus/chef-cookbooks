#install openjdk
package "openjdk-7-jre-headless" do
  action :install
end

#mod hosts file
template "/etc/security/limits.conf" do
  source "limits.conf.erb"
end

remote_file "/tmp/elasticsearch-0.90.2.deb" do
  source   "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.2.deb"
  mode 00644
end

dpkg_package "/tmp/elasticsearch-0.90.2.deb" do
  action :install
end

#mod hosts file
template "/etc/init.d/elasticsearch" do
  source "elasticsearch_initd.erb"
  variables(
    :es_heap_size => node[:elasticsearch][:es_heap_size]
  )
end


#elasticsearch service
service "elasticsearch" do
  supports :restart => true, :start => true, :stop => true, :status => true
end

node.set[:elasticsearch][:cluster_name] = node.environment

#Get the list of nodes that belong to this elatic search cluster
es_nodes = search(:node, "elasticsearch_cluster_name:#{node[:elasticsearch][:cluster_name]}")

#if there are no nodes that have the plugin_head install, install it on this node
plugin_head_nodes = es_nodes.select {|i| i[:elasticsearch][:plugin_head] == true}
if plugin_head_nodes.empty?
  node.set[:elasticsearch][:plugin_head] = true
end

if node[:elasticsearch][:plugin_head]
  execute "install head plugin" do
    command "sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head"
    action :run
  end

  execute "install bigdesk plugin" do
    command "sudo /usr/share/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk"
    action :run
  end
end

host_entry = "#{node[:rackspace][:private_ip]}\t#{node[:hostname]}\n"
es_hosts_entries = []

for es_node in es_nodes
  es_hosts_entries.push("#{es_node[:rackspace][:private_ip]}\t#{es_node[:hostname]}\n")
end

#mod hosts file
template "/etc/hosts" do
  source "hosts.erb"
  variables(
    :host_entry => host_entry,
    :es_ips_hostnames => es_hosts_entries
  )
end

#Get the unicast factor (the number of nodes for each unicast nodes)
unicast_factor = node[:elasticsearch][:unicast_host_for_every_n_nodes] 
#Calculate the number of unicast nodes needed for the cluster
num_unicast_nodes = es_nodes.count / unicast_factor
num_unicast_nodes = num_unicast_nodes.ceil

#Create a list of only hostnames for the nodes in the cluster
node_names = []
for es_node in es_nodes
  node_names.push("#{es_node[:hostname]}")
end
#sort the host_name list alphabetically
node_names.sort!

#build the list of unicast node names by selecting the fist N 
#number of hostnames form the list for N unicast nodes needed
unicast_nodes = []
for i in 0..num_unicast_nodes
  unicast_nodes.push(node_names[i])
end

node.set[:elasticsearch][:discovery_zen_ping_unicast_hosts] = unicast_nodes.join(",")

#write elasticsearch config file
template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  variables(
    :cluster_name => node[:elasticsearch][:cluster_name],
    :hostname => node[:hostname],
    :num_shards => node[:elasticsearch][:num_shards],
    :num_replicas => node[:elasticsearch][:num_replicas],
    :network_host => node[:hostname],
    :gateway_recover_after_nodes => node[:elasticsearch][:gateway_recover_after_nodes],
    :gateway_expected_nodes => node[:elasticsearch][:gateway_expected_nodes],
    :discovery_zen_minimum_master_nodes => node[:elasticsearch][:discovery_zen_minimum_master_nodes],
    :discovery_zen_ping_multicast_enabled => node[:elasticsearch][:discovery_zen_ping_multicast_enabled],
    :discovery_zen_ping_unicast_hosts => node[:elasticsearch][:discovery_zen_ping_unicast_hosts] 
  )
  notifies :restart, resources(:service => "elasticsearch")
end
