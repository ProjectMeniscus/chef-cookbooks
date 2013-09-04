meniscus Cookbook
=================

This cookbook installs `Meniscus`[cookbook](https://github.com/ProjectMeniscus/meniscus) node instances.  The default recipe installs a worker node.

For more information on [Project Meniscus](http://projectmeniscus.org/)

Requirements
------------
Chef 10.18.2 

Platform
--------
- Ubuntu

Tested on:
- Ubuntu 12.04

Cookbooks
---------
#### packages
- `python` - Meniscus is written in Python.

Attributes
----------
#### meniscus instance attributes
* `default[:meniscus][:personality]` - `String` - Meniscus instance personality type
* `default[:meniscus][:paired]` - `Boolean` - Pairing status for a meniscus instance
* `default[:meniscus][:cluster_name]` - `String` - Name of meniscus cluster
* `default[:meniscus][:port]` - `String` - Port number the meniscus instance should bind to
* `default[:meniscus][:syslog_port]` - `String` - Port number that incoming syslog messages will bind to
* `default[:meniscus][:auto_upgrade]` - `Boolean` - Will apt-upgrade meniscus application automatically

#### meniscus python and configuration attributes
* `default[:meniscus][:pynopath]` - `String` - Python Path on meniscus instance
* `default[:meniscus][:config_file]` - `String` - Location of meniscus configuration file

#### meniscus instance logging attributes
* `default[:meniscus][:log_debug]` - `Boolean` - Debug mode for meniscus logging
* `default[:meniscus][:log_file]` - `String` - Location of meniscus log file

#### Meniscus pairing attributes
* `default[:meniscus][:coordinator_uri]` - `String` - Coordinator uri for pairing

#### Meniscus coordinator database attributes
* `default[:meniscus][:coordinator_db_databag_item]` - `String` - Chef coordinator databag item
* `default[:meniscus][:coordinator_db_cluster_name]` - `String` - Coordinator database cluster name 
* `default[:meniscus][:coordinator_db_adapter_name]` - `String` - Coordinator database adapter name
* `default[:meniscus][:coordinator_db_active]` - `Boolean` - Coordinator database active
* `default[:meniscus][:coordinator_db_servers]` - `String` - Location of coordinator database server
* `default[:meniscus][:coordinator_db_database]` - `String` - Name of coordinator database
* `default[:meniscus][:coordinator_db_username]` - `String` - Coordinator database username
* `default[:meniscus][:coordinator_db_password]` - `String` - Coordinator database password

#### Meniscus short term storage attributes
* `default[:meniscus][:short_term_store_cluster_name]` - `String` - Name of short term storage cluster
* `default[:meniscus][:short_term_store_adapter_name]` - `String` - Name of short term storage adapter
* `default[:meniscus][:short_term_store_active]` - `Boolean` - Short term storage is active
* `default[:meniscus][:short_term_store_servers]` - `String` - Short term storage server uri
* `default[:meniscus][:short_term_store_database]` - `String` - Name of short term storage database
* `default[:meniscus][:short_term_store_username]` - `String` - Short term storage username
* `default[:meniscus][:short_term_store_password]` - `String` - Short term storage password

#### Meniscus data sinks attributes
* `default[:meniscus][:data_sinks_valid_sinks]` - `String` -  List of valid datasinks
* `default[:meniscus][:data_sinks_default_sink]` - `String` - List of default datasinks

#### Meniscus default data sink attributes
* `default[:meniscus][:default_sink_cluster_name]` - `String` - Default datasink cluster name
* `default[:meniscus][:default_sink_adapter_name]` - `String` - Short term storage adapter name
* `default[:meniscus][:default_sink_active]` - `Boolean` - Is default data sink active
* `default[:meniscus][:default_sink_servers]` - `String` - Default data sink uri
* `default[:meniscus][:default_sink_index]` - `String` - default data sink index
* `default[:meniscus][:default_sink_bulk_size]` - `String` - default data sink bulk size

#### Meniscus default hdfs sink attributes
* `default[:meniscus][:hdfs_sink_hostname]` - `String` - hdfs sink hostname 
* `default[:meniscus][:hdfs_sink_port]` - `String` - hdfs sink port
* `default[:meniscus][:hdfs_sink_user_name]` - `String` - hdfs sink user name
* `default[:meniscus][:hdfs_sink_base_directory]` - `String` - hdfs sink base directory
* `default[:meniscus][:hdfs_sink_transaction_expire]` - `Integer` - hdfs sink transaction expiration time
* `default[:meniscus][:hdfs_sink_transfer_frequency]` - `Integer` - hdfs sink transfer frequency

#### Meniscus default celery attributes
* `default[:meniscus][:celery_broker_url]` - `String` - celery broker url
* `default[:meniscus][:celery_concurrency]` - `String` - celery concurrency
* `default[:meniscus][:celery_disbale_rate_limits]` - `Boolean` - Is celery rate limiting disabled
* `default[:meniscus][:celery_task_serializer]` - `String` - Celery task serializer format

#### Meniscus default uwsgi attributes
* `default[:meniscus][:uwsgi_protocol]` - `String` - uwsgi protocol
* `default[:meniscus][:uwsgi_processes]` - `String` - uwsgi processes
* `default[:meniscus][:uwsgi_cache_expires]` - `Integer` - uwsgi cache expiration time
* `default[:meniscus][:uwsgi_paste_file]` - `String` - uwsgi paste file location

#### Meniscus default json, liblognorm and ethernet attributes
* `default[:meniscus][:json_schema_dir]` - `String` - json schema directory location
* `default[:meniscus][:liblognorm_rules_dir]` - `String` - liblognorm rules directory location
* `default[:meniscus][:default_ifname]` - `String` - Default interface name (eth0, eth1...)

#### Meniscus default cache attributes
* `default[:meniscus][:uwsgi_config_cache_items]` - `Integer` - number of cached uwsgi configuration items
* `default[:meniscus][:uwsgi_tenant_cache_items]` - `Integer` - number of cached uwsgi tenants items
* `default[:meniscus][:uwsgi_token_cache_items]` - `Integer` - number of cached uwsgi cache items

Usage
-----
#### meniscus::default

Just include `meniscus` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[meniscus]"
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
