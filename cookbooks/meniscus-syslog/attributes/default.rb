default[:meniscus][:personality] = "syslog"
normal[:cloudpassage][:server_tag] = "#{node.environment}-syslog"

normal[:meniscus_syslog][:zmq_bind_host] = node[:rackspace][:private_ip]
