# meniscus portal maintenance
default['meniscus_portal']['auto_upgrade'] = false

default['meniscus_portal']['config_dir'] = "/etc/meniscus-portal"
default['meniscus_portal']['config_template'] = "portal.conf.erb"

# portal.conf attributes
default['meniscus_portal']['processes'] = 0
#default['meniscus_portal']['syslog_bind_host'] = 127.0.0.1
default['meniscus_portal']['syslog_bind_port'] = 5140

#efault['meniscus_portal']['zmq_bind_host'] = 127.0.0.1
default['meniscus_portal']['zmq_bind_port'] = 5000

default['meniscus_portal']['console'] = true
default['meniscus_portal']['logfile'] = '/var/log/meniscus-portal/portal.log'
default['meniscus_portal']['verbosity'] = 'DEBUG'









