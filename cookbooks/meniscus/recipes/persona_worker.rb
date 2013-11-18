node.set[:meniscus][:personality] = "worker"
node.set[:meniscus][:coordinator_db_active] = false
node.set[:meniscus][:short_term_store_active] = false
node.set[:meniscus][:default_sink_active] = true 
node.set[:meniscus][:celery_concurrency] = "8"
node.set[:meniscus][:uwsgi_processes] = "4"
