# meniscus-portal cookbook

A wrapper for the portal cookbook that allows portal to bind its Syslog listener and its 
ZeroMQ socket to the Rackspace public cloud service-net ip.  

# Requirements
portal cookbook

# Attributes

# Recipes
default -  Sets the portal bind address to node[:rackspace][:private_ip].  
If run with chef-solo the default portal settings are kept.

Also assigns default[:meniscus][:personality] = "portal" so the node can 
be discovered with chef search

# Author

Author:: Steven Gonzales (<steven.gonzales@rackspace.com>)
