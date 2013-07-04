default[:meniscus][:personality] = "cbootstrap"
default[:meniscus][:cluster_name] = "meniscus"
default[:meniscus][:port] = "8080"
default[:meniscus][:syslog_port] = "5140"

default[:meniscus][:log_debug] = false
default[:meniscus][:log_file] = "/var/log/meniscus/meniscus.log"

default[:meniscus][:coordinator_db_cluster_naame] = "" 
default[:meniscus][:coordinator_db_adapter_name] = "mongodb"
default[:meniscus][:coordinator_db_servers] = "configdb-dev.projectmeniscus.org:27017"
default[:meniscus][:coordinator_db_database] = "test"
default[:meniscus][:coordinator_db_username] = "test"
default[:meniscus][:coordinator_db_password] = "test"

default[:meniscus][:short_term_store_cluster_naame] = ""
default[:meniscus][:short_term_store_adapter_name] = "mongodb"
default[:meniscus][:short_term_store_servers] = "shorttermdb-dev.projectmeniscus.org:27017"
default[:meniscus][:short_term_store_database] = "test"
default[:meniscus][:short_term_store_username] = "test"
default[:meniscus][:short_term_store_password] = "test"

default[:meniscus][:data_sinks_valid_sinks] = "elasticsearch,hdfs"
default[:meniscus][:data_sinks_default_sink] = "elasticsearch"

default[:meniscus][:elasticsearch_sink_cluster_name] = ""
default[:meniscus][:default_sink_adapter_name] = "elasticsearch-dev.projectmeniscus.org:9200" 
default[:meniscus][:default_sink_servers] = "configdb-dev.projectmeniscus.org"
default[:meniscus][:default_sink_index] = "logs-dev"

default[:meniscus][:hdfs_sink_hostname] = "hortonworks.projectmeniscus.org" 
default[:meniscus][:hdfs_sink_port] = "50070"
default[:meniscus][:hdfs_sink_user_name] = "hdfs"
default[:meniscus][:hdfs_sink_base_directory] = "hdfs"
default[:meniscus][:hdfs_sink_transaction_expire] = 300
default[:meniscus][:hdfs_sink_transfer_frequency] = 60

default[:meniscus][:celery_broker_url] = "librabbitmq://guest@localhost//"
default[:meniscus][:celery_concurrency] = "32"
default[:meniscus][:celery_disbale_rate_limits] = "True"
default[:meniscus][:celery_task_serializer] = "json"

default[:meniscus][:json_schema_dir] = "/etc/meniscus/schemas/"
