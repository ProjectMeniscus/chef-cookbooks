# hayrack cookbook
Installs Hayrack - A tool for capturing syslog messages from STDIN, such as when run as a program destination by Syslog-NG, and pushing messages over ZeroMQ to downstream hosts.

# Attributes

*`default[:hayrack][:zmq_bind_host] `- ip address to bind ZeroMQ Push Socket
*`default[:hayrack][:zmq_bind_port] `- port to bind ZeroMQ Push Socket
*`default[:hayrack][:zmq_hwm] ` - the ZMQ high water mark, controls how many messages are buffered before ZMQ send blocks
*`default[:hayrack][:zmq_linger] ` - deterines how many milliseconds to wait to process messages before socket is closed

*`default[:hayrack][:console] ` - log to console
*`default[:hayrack][:logfile] ` - file to log to
*`default[:hayrack][:log_verbosity] ` - log level

# Recipes

default - installs hayrack from a deb

# Author

Author:: Steven Gonzales (<steven.gonzales@rackspace.com>)
