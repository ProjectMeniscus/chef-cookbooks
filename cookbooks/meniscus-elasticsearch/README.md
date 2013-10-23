# meniscus-elasticsearch cookbook

# Requirements

See Berksfile and Metadata.rb for requirements details.

# Usage

Include `meniscus-elasticsearch` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[meniscus-elasticsearch]"
  ]
}
```

# Attributes

Java Settings
* `override[:java][:jdk_version] ` - `String` - Sets the java version to installed

ElasticSearch Basics
* `normal[:elasticsearch][:port] ` - `String` - sets the port for meniscus nodes to communicate with es
* `normal[:elasticsearch][:http][:port] ` - `String` - sets the port for elasticsearch to listen on
* `normal[:elasticsearch][:cluster][:name] ` - `String` - name of the cluster
* `normal[:elasticsearch][:plugins] ` - `hash` - a hash of plugins to install with their settings

Apply search query for clustering of ElasticSearch nodes
* `normal[:elasticsearch][:discovery][:search_query] ` - `String` - a query to use for chef server search 
* `normal[:elasticsearch][:discovery][:node_attribute]` - `String` - the node attribute returned form the chef server search to use for clustering IE: node[:rackspace][:private_ip] would be defined as "rackspace.private_ip"


ElasticSearch index default settings
* `normal[:elasticsearch][:index][:number_of_shards]` - `Integer` - number of shards an index will be split into by default
* `normal[:elasticsearch][:index][:number_of_replicas]` - `Integer` - number of times each shard will be replicated

ElasticSearch recovery
* `normal[:elasticsearch][:gateway][:recover_after_nodes]` - `Integer` - Determines how many nodes must become available for recovery tp start
* `normal[:elasticsearch][:gateway][:expected_nodes]` - `Integer` - Number fo nodes expected in the cluster

The indexing buffer setting allows to control how much memory will be allocated for the indexing process. It is a global setting that bubbles down to all 
the different shards allocated on a specific node.
normal[:elasticsearch][:indices][:memory][:index_buffer_size]` - `String` - accepts either a percentage or a byte size value. It defaults to 10%

* `normal[:elasticsearch][:indices][:ttl][:interval]` - `String` - set how often expired documents will be automatically deleted. The default value is 60s
* `normal[:elasticsearch][:indices][:ttl][:bulk_size]` - `String` -  The deletion orders are processed by bulk, The default value is 10000.

Each shard has a transaction log or write ahead log associated with it. It allows 
to guarantee that when an index/delete operation occurs, it is applied atomically, 
while not "committing" the internal Lucene index for each request. A flush 
("commit") still happens based on several parameters:
* `normal[:elasticsearch][:index][:translog][:flush_threshold_ops]` - `String` - After how many operations to flush.  
* `normal[:elasticsearch][:index][:translog][:flush_threshold_size]` - `String` - Once the translog hits this size, a flush will happen. Defaults to 200mb
* `normal[:elasticsearch][:index][:translog][:flush_threshold_period]` - `String` - The period with no flush happening to force a flush. Defaults to 30m


# Author

Author:: Steven Gonzales (steven.gonzales@rackspace.com)
