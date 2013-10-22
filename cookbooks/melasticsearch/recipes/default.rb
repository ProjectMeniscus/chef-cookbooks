#install openjdk
package "openjdk-7-jre-headless" do
  action :install
end

#mod limits.conf
template "/etc/security/limits.conf" do
  source "limits.conf.erb"
end

#downlod elasticsearch package
remote_file node[:elasticsearch][:download_dir] + node[:elasticsearch][:package] do
  source node[:elasticsearch][:download_url] + node[:elasticsearch][:package]
  mode 00644
end

#install elasticsearch
dpkg_package node[:elasticsearch][:download_dir] + node[:elasticsearch][:package] do
  action :install
  options "--force-confold"
end

#define elasticsearch service
service "elasticsearch" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action :enable
end

#set heap_size as a percentage of ram
memory_total = node[:memory][:total]
memory_total.slice! "kB"

memory = memory_total.to_i
es_heap_size_kb = memory * node[:elasticsearch][:heap_size_percent] / 100
es_heap_size_mb = es_heap_size_kb / 1024
es_heap_size_mb = es_heap_size_mb.ceil
es_heap_size = "#{es_heap_size_mb}m"


node[:elasticsearch][:es_heap_size]
#mod elasticsearch init script
template "/etc/init.d/elasticsearch" do
  source "elasticsearch_initd.erb"
  variables(
    :es_heap_size => es_heap_size
  )
end

execute "install head plugin" do
  not_if  { ::File.exists?("/usr/share/elasticsearch/plugins/head") }
  command "/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head"
  action :run
end

execute "install ElasticHQ plugin" do
  not_if  { ::File.exists?("/usr/share/elasticsearch/plugins/HQ") }
  command "/usr/share/elasticsearch/bin/plugin -install royrusso/elasticsearch-HQ"
  action :run
end

execute "install bigdesk plugin" do
  not_if  { ::File.exists?("/usr/share/elasticsearch/plugins/bigdesk") }
  command "/usr/share/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk"
  action :run
end

#name the cluster after the chef environment this node is edployed in
node.set[:elasticsearch][:cluster_name] = node.environment

#Get the list of nodes that belong to this elatic search cluster
es_nodes = search(:node, "elasticsearch_cluster_name:#{node[:elasticsearch][:cluster_name]}")

#get the ip and hostname for this node
host_entry = "#{node[:rackspace][:private_ip]}\t#{node[:hostname]}\n"
es_hosts_entries = []

#get the service net ip and hostname for elasticsearch node in the cluster
for es_node in es_nodes
  es_hosts_entries.push("#{es_node[:rackspace][:private_ip]}\t#{es_node[:hostname]}\n")
end

#write the hosts file with the service net address of every node in the cluster
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
    :discovery_zen_ping_unicast_hosts => node[:elasticsearch][:discovery_zen_ping_unicast_hosts],
    :mlockall => node[:elasticsearch][:mlockall],
    :index_buffer_size => node[:elasticsearch][:index_buffer_size],
    :ttl_interval => node[:elasticsearch][:ttl_interval],
    :ttl_bulk_size => node[:elasticsearch][:ttl_bulk_size],
    :translog_flush_threshold_ops => node[:elasticsearch][:translog_flush_threshold_ops],
    :translog_flush_threshold_size => node[:elasticsearch][:translog_flush_threshold_size],
    :translog_flush_threshold_period => node[:elasticsearch][:translog_flush_threshold_period]
  )
  notifies :restart, resources(:service => "elasticsearch")
end
