CloudPassage Cookbook
=====================
Installs the cloud passage agent for controlling firewalls.

Requirements
------------

#### packages
- `apt`

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