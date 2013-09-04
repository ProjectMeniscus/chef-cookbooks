mmongo Cookbook
===============

This cookbook installs a new mongod instance in a replica set.

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
Requires `apt` - mmongo uses the apt cookbook to configure the 10gen apt-get repository

Tested with:
`apt` [cookbook](https://github.com/opscode-cookbooks/apt/commit/b58c75536300794e5b5ffa8747fc9e6c48a4e5ce) release v2.1.1

Attributes
----------

#### mmongo::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
    <tr>
    <td><tt>[:mmongo][:databag_item]</tt></td>
    <td>String</td>
    <td>Chef Server stored databag item</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>[:mmongo][:dbpath]</tt></td>
    <td>String</td>
    <td>Full path to the directory where mongo should store data files.</td>
    <td><tt>/var/lib/mongodb</tt></td>
  </tr>
    <tr>
    <td><tt>[:mmongo][:logpath]</tt></td>
    <td>String</td>
    <td>Full path to the directory where mongo should save log files.</td>
    <td><tt>/var/log/mongodb</tt></td>
  </tr>
    <tr>
    <td><tt>[:mmongo][:port]</tt></td>
    <td>Integer</td>
    <td>Port number the mongo instance should bind to.</td>
    <td><tt>27017</tt></td>
  </tr>
    <tr>
    <td><tt>[:mmongo][:replset_name]</tt></td>
    <td>String</td>
    <td>Replica set name used to configure all members of the set.</td>
    <td><tt>rs0</tt></td>
  </tr>
    <tr>
    <td><tt>[:mmongo][:keyfile]</tt></td>
    <td>String</td>
    <td>Full path to directory where mongo should store key file</td>
    <td><tt>/etc/mongodb.key</tt></td>
  </tr>
</table>

Usage
-----
#### mmongo::default
Just include `mmongo` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mmongo]"
  ]
}
```

License & Authors
-----------------
- Author:: Douglas Mendizabal (<douglas.mendizabal@RACKSPACE.COM>)
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
