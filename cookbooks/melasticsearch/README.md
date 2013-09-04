melasticsearch Cookbook
===============
Installs and configures elasticsearch clustering. Configured as a data sink for the meniscus application

Requirements
------------
Chef 10.18.2 

Platform
--------
- Ubuntu

Tested on:
- Ubuntu 12.04

Attributes
----------
#### Generic elasticsearch node attributes
* `default[:elasticsearch][:port]` - `String` - Elasticsearch incoming traffic port
* `default[:elasticsearch][:cluster_port]` - `String` - Elasticsearch internode communication port
* `default[:elasticsearch][:es_heap_size]` - `String` - Elasticsearch heap size
* `default[:elasticsearch][:plugin_head]` - `Boolean` - Install elasticsearch plugin_head plugin

#### meniscus elasticsearch cluster configuration attributes
* `default[:elasticsearch][:discovery_zen_ping_unicast_hosts]` - `List` - unicast discovery host list
* `default[:elasticsearch][:cluster_name]` - `String` - Elasticsearch cluster name
* `default[:elasticsearch][:num_shards]` - `Integer` - Number of shards
* `default[:elasticsearch][:num_replicas]` - `Integer` - Number of replica sets
* `default[:elasticsearch][:gateway_recover_after_nodes]` - `Integer` - Allow recovery process after N nodes in a cluster are up
* `default[:elasticsearch][:gateway_expected_nodes]` - `Integer` - Set how many nodes are expected in this cluster.
* `default[:elasticsearch][:discovery_zen_minimum_master_nodes]` - `Integer` - Set minimum master nodes
* `default[:elasticsearch][:discovery_zen_ping_multicast_enabled]` - `Boolean` - Enable multicast
* `default[:elasticsearch][:unicast_host_for_every_n_nodes]` - `Integer` - Number of unicast hosts for N nodes

#### newrelic elasticsearch configuration attributes
* `default[:elasticsearch][:use_newrelic]` - `Boolean` - Should node use newrelic monitoring tool
* `default[:elasticsearch][:newrelic_plugin_url]` - `String` - newrelic plugin url
* `default[:elasticsearch][:newrelic_plugin_jar]` - `String` - newrelic plugin jar location

Usage
-----
Include `melasticsearch` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[melasticsearch]"
  ]
}
```

License & Authors
-----------------
- Author:: Steven Gonzales (steven.gonzales@RACKSPACE.COM)

```text
Copyright:: 2009-2013 Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
