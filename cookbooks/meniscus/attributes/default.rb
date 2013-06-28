default[:meniscus][:personality] = "cbootstrap"
default[:meniscus][:cluster_name] = "meniscus"
default[:meniscus][:port] = "8080"
default[:meniscus][:syslog_port] = "5140"

default[:meniscus][:data_sinks_valid_sinks] = "elasticsearch,hdfs"
default[:meniscus][:data_sinks_default_sink] = "elasticsearch"

default[:meniscus][:coordinator_db_adapter_name] = "mongodb"
default[:meniscus][:coordinator_db_servers] = "configdb-dev.projectmeniscus.org:27017"
default[:meniscus][:coordinator_db_database] = "test"
default[:meniscus][:coordinator_db_username] = "test"
default[:meniscus][:coordinator_db_password] = "test"

default[:meniscus][:default_sink_adapter_name] = "elasticsearch-dev.projectmeniscus.org:9200" 
default[:meniscus][:default_sink_servers] = "configdb-dev.projectmeniscus.org"
default[:meniscus][:default_sink_index] = "logs-dev"


default[:meniscus][:short_term_sink_adapter_name] = "mongodb"
default[:meniscus][:short_term_sink_servers] = "shorttermdb-dev.projectmeniscus.org:27017"
default[:meniscus][:short_term_sink_database] = "test"
default[:meniscus][:short_term_sink_username] = "test"
default[:meniscus][:short_term_sink_password] = "test"

default[:meniscus][:celery_broker_url] = "librabbitmq://guest@localhost//"
default[:meniscus][:celery_concurrency] = "32"
default[:meniscus][:celery_disbale_rate_limits] = "True"
default[:meniscus][:celery_task_serializer] = "json"
default[:meniscus][:data_sinks_valid_sinks] = "elasticsearch,hdfs"
default[:meniscus][:data_sinks_default_sinks] = "elasticsearch"
default[:meniscus][:json_schema_dir] = "/etc/meniscus/schemas/"
