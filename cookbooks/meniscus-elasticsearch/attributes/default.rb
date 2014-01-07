#configure cloudpassage groupnormal
normal[:cloudpassage][:server_tag] = "#{node.environment}-elasticsearch"

#provision Rackspace cloud block storage
normal[:blockstorage_lvm][:no_volumes] = 2
normal[:blockstorage_lvm][:volume_type] = "SATA"
normal[:blockstorage_lvm][:volume_size] = 1024
normal[:blockstorage_lvm][:volume_group_name] = "vg00"
normal[:blockstorage_lvm][:logical_volume_name] = "esvolume"
normal[:blockstorage_lvm][:filesystem] = "ext4"
normal[:blockstorage_lvm][:mount_point] = "/usr/local/var/data/elasticsearch"

#elasticsearch settings
override[:java][:jdk_version] = "7"

normal[:elasticsearch][:port] = "9200"
normal[:elasticsearch][:http][:port] = "9200"
normal[:elasticsearch][:cluster][:name] = node.environment
normal[:elasticsearch][:plugins] = {
	"lukas-vlcek/bigdesk" => {},
	"mobz/elasticsearch-head" => {},
	"royrusso/elasticsearch-HQ" => {}
}

#Apply search query for clustering of es nodes
normal[:elasticsearch][:discovery][:search_query] = "elasticsearch_cluster_name:#{node[:elasticsearch][:cluster][:name]}"
normal[:elasticsearch][:discovery][:node_attribute] = "rackspace.private_ip"



normal[:elasticsearch][:index][:number_of_shards] = 12
normal[:elasticsearch][:index][:number_of_replicas] = 2


normal[:elasticsearch][:gateway][:recover_after_nodes] = 4
normal[:elasticsearch][:gateway][:expected_nodes] = 12

# The indexing buffer setting allows to control how much memory will be allocated for the indexing process. It is a global setting that bubbles down to all 
# the different shards allocated on a specific node.
#
# The indices.memory.index_buffer_size accepts either a percentage or a byte size value. It defaults to 10%, meaning that 10% of the total memory allocated
# to a node will be used as the indexing buffer size. This amount is then divided between all the different shards. Also, if percentage is used, allow to 
# set min_index_buffer_size (defaults to 48mb) and max_index_buffer_size which by default is unbounded.
normal[:elasticsearch][:indices][:memory][:index_buffer_size] = "50%"

#You can dynamically set the indices.ttl.interval allows to set how often expired documents will be automatically deleted. The default value is 60s.
normal[:elasticsearch][:indices][:ttl][:interval] = "3600s"
#The deletion orders are processed by bulk. You can set indices.ttl.bulk_size to fit your needs. The default value is 10000.
normal[:elasticsearch][:indices][:ttl][:bulk_size] = "10000"

# Each shard has a transaction log or write ahead log associated with it. It allows 
# to guarantee that when an index/delete operation occurs, it is applied atomically, 
# while not "committing" the internal Lucene index for each request. A flush 
# ("commit") still happens based on several parameters:

# After how many operations to flush. Defaults to 5000
normal[:elasticsearch][:index][:translog][:flush_threshold_ops] = "50000"
# Once the translog hits this size, a flush will happen. Defaults to 200mb
normal[:elasticsearch][:index][:translog][:flush_threshold_size] = "200mb"
# The period with no flush happening to force a flush. Defaults to 30m
normal[:elasticsearch][:index][:translog][:flush_threshold_period] = "30m"

normal.elasticsearch[:custom_config] = {
	"indices.memory.index_buffer_size" => node[:elasticsearch][:indices][:memory][:index_buffer_size],
	"indices.ttl.interval" => node[:elasticsearch][:indices][:ttl][:interval],
	"indices.ttl.bulk_size" => node[:elasticsearch][:indices][:ttl][:bulk_size],
	"index.translog.flush_threshold_ops" => node[:elasticsearch][:index][:translog][:flush_threshold_ops],
	"index.translog.flush_threshold_size" => node[:elasticsearch][:index][:translog][:flush_threshold_size],
	"index.translog.flush_threshold_period" => node[:elasticsearch][:index][:translog][:flush_threshold_period]

}

#Settings for newrelic monitoring
normal[:meetme_newrelic_plugin][:elasticsearch][:clustername] = node[:elasticsearch][:cluster][:name]
normal[:meetme_newrelic_plugin][:elasticsearch][:host] = "localhost"
normal[:meetme_newrelic_plugin][:elasticsearch][:port] = node[:elasticsearch][:http][:port]
normal[:meetme_newrelic_plugin][:elasticsearch][:scheme] = "http"
