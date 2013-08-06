Hostname Cookbook
=====================
configures node hostnames
Requirements
------------

#### packages
- `apt`

Attributes
----------

Usage
-----
#### hostname::default

Just include `cloudpassage` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hostname]"
  ]
}
```

License and Authors
-------------------
Licensed under the APLv2

Author: Steven Gonzales