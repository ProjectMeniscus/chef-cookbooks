default[:meniscus][:personality] = "portal"
normal[:cloudpassage][:server_tag] = "#{node.environment}-portal"
normal[:meniscus_portal][:syslog_bind_host] = node[:rackspace][:private_ip]
normal[:meniscus_portal][:zmq_bind_host] = node[:rackspace][:private_ip]