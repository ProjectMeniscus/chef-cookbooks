mmongo Cookbook
===============

This cookbook installs a new mongod instance in a replica set.

Requirements
------------

#### cookbooks
- `apt` - mmongo uses the apt cookbook to configure the 10gen apt-get repository.

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