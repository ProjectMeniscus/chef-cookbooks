node.set[:meniscus][:personality] = "coordinator"
node.set[:meniscus][:coordinator_db_active] = true
node.set[:meniscus][:short_term_store_active] = false
node.set[:meniscus][:default_sink_active] = false 
node.set[:meniscus][:celery_concurrency] = "2"
node.set[:meniscus][:uwsgi_processes] = "2"
