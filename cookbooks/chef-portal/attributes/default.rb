# meniscus portal maintenance
default['meniscus_portal']['auto_upgrade'] = false

default['meniscus_portal']['config_dir'] = "/etc/meniscus-portal"

# portal.conf attributes
default['meniscus_portal']['processes'] = 0
default['meniscus_portal']['syslog_bind_host'] = node[:ipaddress]
default['meniscus_portal']['syslog_bind_port'] = 5140

default['meniscus_portal']['zmq_bind_host'] = node[:ipaddress]
default['meniscus_portal']['zmq_bind_port'] = 5000

default['meniscus_portal']['console'] = true
default['meniscus_portal']['logfile'] = '/var/log/meniscus-portal/portal.log'
default['meniscus_portal']['verbosity'] = 'DEBUG'









