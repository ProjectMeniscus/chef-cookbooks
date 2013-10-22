
default[:elasticsearch][:port] = "9200"
default[:elasticsearch][:cluster_port] = "9300"
default[:elasticsearch][:heap_size_percent] = 60
default[:elasticsearch][:plugin_head] = false

default[:elasticsearch][:discovery_zen_ping_unicast_hosts] = nil
default[:elasticsearch][:cluster_name] = "es_cluster"
default[:elasticsearch][:num_shards] = 8
default[:elasticsearch][:num_replicas] = 3
default[:elasticsearch][:gateway_recover_after_nodes] = 8
default[:elasticsearch][:gateway_expected_nodes] = 24
default[:elasticsearch][:discovery_zen_minimum_master_nodes] = 3
default[:elasticsearch][:discovery_zen_ping_multicast_enabled] = false
default[:elasticsearch][:unicast_host_for_every_n_nodes] = 6
default[:elasticsearch][:mlockall] = true

default[:elasticsearch][:index_buffer_size] = "50%"
default[:elasticsearch][:ttl_interval] = "3600s"
default[:elasticsearch][:ttl_bulk_size] = 10000
default[:elasticsearch][:translog_flush_threshold_ops] = 50000
default[:elasticsearch][:translog_flush_threshold_size] = "200mb"
default[:elasticsearch][:translog_flush_threshold_period] = "30m"


default[:elasticsearch][:package] = "elasticsearch-0.90.5.deb"
default[:elasticsearch][:download_url] = "https://download.elasticsearch.org/elasticsearch/elasticsearch/"
default[:elasticsearch][:download_dir] = "/tmp/"




