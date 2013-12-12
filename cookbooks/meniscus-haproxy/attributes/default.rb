default[:meniscus][:personality] = "haproxy"
normal[:cloudpassage][:server_tag] = "#{node.environment}-haproxy"

normal[:haproxy][:incoming_address] = node[:rackspace][:private_ip]
normal[:haproxy][:incoming_port] = "9200"
normal[:haproxy][:member_port] = "9200"
normal[:haproxy][:httpchk] = true
normal[:haproxy][:enable_admin] = true
normal[:haproxy][:admin][:address_bind] = node[:ipaddress]
normal[:haproxy][:balance_algorithm] = "leastconn"
normal[:haproxy][:enable_default_http] = true