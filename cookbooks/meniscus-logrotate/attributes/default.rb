default[:logrotate_app][:meniscus][:rotate] = 7
default[:logrotate_app][:meniscus][:frequency] = "daily"
default[:logrotate_app][:meniscus][:enable] = true
default[:logrotate_app][:meniscus][:size] = "25M"
default[:logrotate_app][:meniscus][:create] = "644 meniscus adm"
default[:logrotate_app][:meniscus][:options] = ["missingok", "compress", "delaycompress", "notifempty"]
