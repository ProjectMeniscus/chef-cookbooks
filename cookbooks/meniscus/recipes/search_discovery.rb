node.set[:meniscus][:cluster_name] = node.chef_environment

if node[:meniscus][:coordinator_db_active]
	#search chef server for the coordinator_db database nodes
	node.set[:meniscus][:coordinator_db_cluster_name] = "#{node.environment}_configdb"
	coordinator_db_nodes = search(:node, "mmongo_replset_name:#{node[:meniscus][:coordinator_db_cluster_name]}")
	#create a new array containg only the ip_address:port_no for each of the database nodes
	coordinator_db_ip = []
	coordinator_db_nodes.each do |coordinator_db_node|
	  coordinator_db_ip.push([coordinator_db_node[:rackspace][:private_ip], coordinator_db_node[:mmongo][:port]].join(':'))  
	end

	node.set[:meniscus][:coordinator_db_servers] = coordinator_db_ip.join(',')
end

if node[:meniscus][:short_term_store_active]
	node.set[:meniscus][:short_term_store_cluster_name] = "#{node.environment}_store"

	#search chef server for the short_term_store database nodes
	short_term_store_nodes = search(:node, "mmongo_replset_name:#{node[:meniscus][:short_term_store_cluster_name]}")
	#create a new array containg only the ip_address:port_no for each of the database nodes
	short_term_store_ip = []
	short_term_store_nodes.each do |short_term_store_node|
	  short_term_store_ip.push([short_term_store_node[:rackspace][:private_ip], short_term_store_node[:mmongo][:port]].join(':'))  
	end

	node.set[:meniscus][:short_term_store_servers] = short_term_store_ip.join(',')
end

if node[:meniscus][:default_sink_active]
	#search chef server for the elasticsearch nodes
	es_nodes = search(:node, "elasticsearch_cluster_name:#{node.environment}")
	#create a new array containg only the ip_address:port_no for each of the es nodes
	es_nodes_ip = []
	es_nodes.each do |es_node|
	  es_nodes_ip.push([es_node[:rackspace][:private_ip], es_node[:elasticsearch][:port]].join(':')) 
	end

	node.set[:meniscus][:default_sink_servers] = es_nodes_ip.join(',')
end


if node[:meniscus][:coordinator_db_active]
	#set CoordinatorDB username/password
	if node[:meniscus][:coordinator_db_databag_item]
	  coordinator_db_settings = data_bag_item(node.chef_environment, node[:meniscus][:coordinator_db_databag_item])
	  node.set[:meniscus][:coordinator_db_username]  = coordinator_db_settings["meniscus_user"]
	  node.set[:meniscus][:coordinator_db_password] = coordinator_db_settings["meniscus_pass"]
	end
end 

if node[:meniscus][:short_term_store_active]
	if node[:meniscus][:short_term_store_databag_item]
	  short_term_store_settings = data_bag_item(node.chef_environment, node[:meniscus][:short_term_store_databag_item])
	  node.set[:meniscus][:short_term_store_username] = short_term_store_settings["meniscus_user"]
	  node.set[:meniscus][:short_term_store_password] = short_term_store_settings["meniscus_pass"]
	end
end

if node[:meniscus][:personality] == "worker"
	portal_nodes = es_nodes = search(:node, "chef_environment:#{node.environment} AND meniscus_personality:portal")
	zmq_hosts = []
	portal_nodes.each do |portal_node|
		zmq_hosts.push([portal_node[:meniscus_portal][:zmq_bind_host], portal_node[:meniscus_portal][:zmq_bind_port]].join(':')) 
	end
	node.set[:meniscus][:zmq_upstream_hosts] = zmq_hosts.join(',')
end

node.set[:meniscus][:uwsgi_socket] = "#{node[:rackspace][:private_ip]}:#{node[:meniscus][:port]}"