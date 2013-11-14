# meniscus-portal cookbook

A wrapper for the portal cookbook that allows portal to bind its Syslog listener and its 
ZeroMQ socket to the Rackspace public cloud service-net ip.  

# Attributes
* `default[:meniscus][:personality] ` - Assigns a personality so the node can be discovered with chef search
* `normal[:cloudpassage][:server_tag] ` - Sets a cloudpassage tag to put the node in the correct firewall group
* `normal[:meniscus_portal][:syslog_bind_host] ` - Allows us to bind syslog listener to Rackspace service net
* `normal[:meniscus_portal][:zmq_bind_host] ` - Allows us to bind ZeroMQ to Rackspace service net


# Recipes
default -  Sets the portal bind address to node[:rackspace][:private_ip], makes node discoverable through search for a meniscus cluster, configures cloudpassage firewall group.

# Author

Author:: Steven Gonzales (<steven.gonzales@rackspace.com>)
