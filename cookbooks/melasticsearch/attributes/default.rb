
default[:elasticsearch][:port] = "9200"
default[:elasticsearch][:cluster_port] = "9300"
default[:elasticsearch][:es_heap_size] = "256m"
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
default[:elasticsearch][:use_newrelic] = false
default[:elasticsearch][:newrelic_plugin_url] = ""
default[:elasticsearch][:newrelic_plugin_jar] = "elasticsearch-newrelic-master-0.0.1.jar"




