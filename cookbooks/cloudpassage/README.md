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
Requires `apt`

Tested with:
`apt` [cookbook](https://github.com/opscode-cookbooks/apt/tree/fbeb0d4f75fcd9906ca9f860983f13bf46fd96c5) release v1.9.0

Attributes
----------

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
Licensed under the APLv2

Author: Steven Gonzales
