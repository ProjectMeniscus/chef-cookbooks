default[:meniscus][:personality] = "kibana"
normal[:cloudpassage][:server_tag] = "#{node.environment}-kibana"

default[:kibana][:webserver_aliases] = [node[:rackspace][:private_ip]]
default[:kibana][:webserver_listen] = node[:rackspace][:private_ip]

