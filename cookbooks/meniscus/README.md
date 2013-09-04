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

#### meniscus::default

#### meniscus instance attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
    <tr>
    <td><tt>[:meniscus][:personality]</tt></td>
    <td>String</td>
    <td>Meniscus instance personality type</td>
    <td><tt>cbootstrap</tt></td>
  </tr>
  <tr>
    <td><tt>[:meniscus][:paired]</tt></td>
    <td>Boolean</td>
    <td>Pairing status for a meniscus instance</td>
    <td><tt>false</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:cluster_name]</tt></td>
    <td>String</td>
    <td>Name of meniscus cluster</td>
    <td><tt>meniscus</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:port]</tt></td>
    <td>String</td>
    <td>Port number the meniscus instance should bind to</td>
    <td><tt>8080</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:syslog_port]</tt></td>
    <td>String</td>
    <td>Port number that incoming syslog messages will bind to</td>
    <td><tt>5140</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:auto_upgrade]</tt></td>
    <td>Boolean</td>
    <td>Auto upgrade option for meniscus instance</td>
    <td><tt>false</tt></td>
  </tr>
</table>

#### meniscus python and configuration attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
    <tr>
    <td><tt>[:meniscus][:pynopath]</tt></td>
    <td>String</td>
    <td>Python Path on meniscus instance</td>
    <td><tt>/usr/share/meniscus/lib/python</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:config_file]</tt></td>
    <td>String</td>
    <td>Location of meniscus configuration file</td>
    <td><tt>/etc/meniscus/meniscus.conf</tt></td>
  </tr>
</table>

#### meniscus instance logging attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
    <tr>
    <td><tt>[:meniscus][:log_debug]</tt></td>
    <td>Boolean</td>
    <td>Sets debug mode for meniscus logging</td>
    <td><tt>true</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:log_file]</tt></td>
    <td>String</td>
    <td>Location of meniscus log file</td>
    <td><tt>/var/log/meniscus/meniscus.log</tt></td>
  </tr>
</table>

#### Meniscus pairing attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
    <tr>
    <td><tt>[:meniscus][:coordinator_uri]</tt></td>
    <td>String</td>
    <td>default coordinator uri for pairing</td>
    <td><tt>localhost</tt></td>
  </tr>
</table>

#### Meniscus coordinator database attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
    <tr>
    <td><tt>[:meniscus][:coordinator_db_databag_item]</tt></td>
    <td>String</td>
    <td>default chef server databag item </td>
    <td><tt>configdb</tt></td>
  </tr>
  <tr>
    <td><tt>[:meniscus][:coordinator_db_cluster_name]</tt></td>
    <td>String</td>
    <td>Coordinator database cluster name</td>
    <td><tt>""</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:coordinator_db_adapter_name]</tt></td>
    <td>String</td>
    <td>coordinator database adapter name</td>
    <td><tt>mongodb</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:coordinator_db_active]</tt></td>
    <td>Boolean</td>
    <td>coordinator database active</td>
    <td><tt>true</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:coordinator_db_servers]</tt></td>
    <td>String</td>
    <td>Default location of coordinator database server</td>
    <td><tt>localhost:27017</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:coordinator_db_database]</tt></td>
    <td>String</td>
    <td>Name of coordinator database</td>
    <td><tt>meniscus</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:coordinator_db_username]</tt></td>
    <td>String</td>
    <td>Default coordinator database username</td>
    <td><tt>test</tt></td>
  </tr>
    <tr>
    <td><tt>[:meniscus][:coordinator_db_password]</tt></td>
    <td>String</td>
    <td>Default coordinator database password</td>
    <td><tt>test</tt></td>
  </tr>
</table>

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
