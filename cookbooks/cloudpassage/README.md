CloudPassage Cookbook
=====================
Installs the cloud passage agent for controlling firewalls.

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
* `default[:cloudpassage][:license_key]` - `String` - Cloud Passage license key

Usage
-----
#### cloudpassage::default

Just include `cloudpassage` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cloudpassage]"
  ]
}
```

License and Authors
-------------------
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
