default[:meniscus][:personality] = "cbootstrap"
default[:meniscus][:paired] = false
default[:meniscus][:cluster_name] = "meniscus"
default[:meniscus][:port] = "8080"
default[:meniscus][:syslog_port] = "5140"
default[:meniscus][:auto_upgrade] = false

default[:meniscus][:pynopath] = "/usr/share/meniscus/lib/python"
default[:meniscus][:config_file]= "/etc/meniscus/meniscus.conf"

default[:meniscus][:log_debug] = true
default[:meniscus][:log_file] = "/var/log/meniscus/meniscus.log"

default[:meniscus][:coordinator_uri] = "localhost"

default[:meniscus][:coordinator_db_databag_item] = "configdb"
default[:meniscus][:coordinator_db_cluster_name] = "" 
default[:meniscus][:coordinator_db_adapter_name] = "mongodb"
default[:meniscus][:coordinator_db_active] = true
default[:meniscus][:coordinator_db_servers] = "localhost:27017"
default[:meniscus][:coordinator_db_database] = "meniscus"
default[:meniscus][:coordinator_db_username] = "test"
default[:meniscus][:coordinator_db_password] = "test"

default[:meniscus][:short_term_store_cluster_name] = ""
default[:meniscus][:short_term_store_adapter_name] = "mongodb"
default[:meniscus][:short_term_store_active] = true
default[:meniscus][:short_term_store_servers] = "localhost:27017"
default[:meniscus][:short_term_store_database] = "meniscus"
default[:meniscus][:short_term_store_username] = "test"
default[:meniscus][:short_term_store_password] = "test"

default[:meniscus][:data_sinks_valid_sinks] = "elasticsearch"
default[:meniscus][:data_sinks_default_sink] = "elasticsearch"

default[:meniscus][:default_sink_cluster_name] = ""
default[:meniscus][:default_sink_adapter_name] = "elasticsearch"
default[:meniscus][:default_sink_active] = true 
default[:meniscus][:default_sink_servers] = "localhost:9200"
default[:meniscus][:default_sink_index] = "logs-dev"
default[:meniscus][:default_sink_bulk_size] = "100"

default[:meniscus][:hdfs_sink_hostname] = "localhost" 
default[:meniscus][:hdfs_sink_port] = "50070"
default[:meniscus][:hdfs_sink_user_name] = "hdfs"
default[:meniscus][:hdfs_sink_base_directory] = "user/hdfs/laas"
default[:meniscus][:hdfs_sink_transaction_expire] = 300
default[:meniscus][:hdfs_sink_transfer_frequency] = 60

default[:meniscus][:celery_broker_url] = "librabbitmq://guest:guest@localhost:5672//"
default[:meniscus][:celery_concurrency] = "7"
default[:meniscus][:celery_disbale_rate_limits] = true
default[:meniscus][:celery_task_serializer] = "json"

default[:meniscus][:uwsgi_protocol] = "http"
default[:meniscus][:uwsgi_processes] = "7"
default[:meniscus][:uwsgi_cache_expires] = 900
default[:meniscus][:uwsgi_paste_file] = "/etc/meniscus/meniscus-paste.ini"

default[:meniscus][:json_schema_dir] = "/etc/meniscus/schemas/"
default[:meniscus][:liblognorm_rules_dir] = "/etc/meniscus/normalizer_rules/"
default[:meniscus][:default_ifname] = "eth0"

default[:meniscus][:uwsgi_config_cache_items] = 10
default[:meniscus][:uwsgi_tenant_cache_items] = 1000
default[:meniscus][:uwsgi_token_cache_items] = 1000


