#global options
default[:syslogng_transport][:log_msg_size] = 9216
default[:syslogng_transport][:threaded] = "yes"

#src settings
default[:syslogng_transport][:bind_host] = node[:ipaddress]
default[:syslogng_transport][:bind_port] = 5140
default[:syslogng_transport][:transport] = "tcp"
default[:syslogng_transport][:keep_hostname] = "yes"
default[:syslogng_transport][:keep_timestamp] = "yes"


default[:syslogng_transport][:flush_lines] = 1

#dst settings
default[:syslogng_transport][:program_dest] = "/usr/bin/python -u #{node[:hayrack][:start_script]}"

#Settings related to message flow and buffering
=begin

The syslog-ng application normally reads a maximum of log_fetch_limit() number of messages from a source.
From TCP and unix-stream sources, syslog-ng reads a maximum of log_fetch_limit() from every connection of the source. The number of connections to the source is set using the max_connections() parameter.
Every destination has an output buffer (log_fifo_size()).
Flow-control uses a control window to determine if there is free space in the output buffer for new messages. Every source has its own control window; log_iw_size() parameter sets the size of the control window.
When a source accepts multiple connections, the size of the control window is divided by the value of the max_connections() parameter and this smaller control window is applied to each connection of the source.
The output buffer must be larger than the control window of every source that logs to the destination.
If the control window is full, syslog-ng stops reading messages from the source until some messages are successfully sent to the destination.
If the output buffer becomes full, and flow-control is not used, messages may be lost.
=end

#src settings for flow control
default[:syslogng_transport][:max_connections] = 10
default[:syslogng_transport][:log_iw_size_per_connection] = 100
default[:syslogng_transport][:log_iw_size] = 1000
default[:syslogng_transport][:log_fetch_limit] = 10 
#dest settings for flow control
default[:syslogng_transport][:log_fifo_size] = 100000
 
default[:syslogng_transport][:flow_control] = true




