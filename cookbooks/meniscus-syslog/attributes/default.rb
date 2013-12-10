default[:meniscus][:personality] = "syslog"
normal[:cloudpassage][:server_tag] = "#{node.environment}-syslog"

normal[:syslogng_transport][:bind_host] = node[:rackspace][:private_ip]
normal[:hayrack][:zmq_bind_host] = node[:rackspace][:private_ip]

normal[:meniscus_syslog][:zmq_bind_host] = node[:hayrack][:zmq_bind_host]
normal[:meniscus_syslog][:zmq_bind_port] = node[:hayrack][:zmq_bind_port]