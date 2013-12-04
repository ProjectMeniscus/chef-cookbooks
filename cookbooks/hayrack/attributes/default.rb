default[:hayrack][:start_script] = "/usr/share/hayrack/bin/run.py"

#core attributes
default[:hayrack][:zmq_bind_host] = node[:ipaddress]
default[:hayrack][:zmq_bind_port] = 5000
default[:hayrack][:zmq_hwm] = 0
default[:hayrack][:zmq_linger] = -1

#logging attributes
default[:hayrack][:console] = true
default[:hayrack][:logfile] = '/var/log/hayrack/hayrack.log'
default[:hayrack][:log_verbosity] = 'DEBUG'