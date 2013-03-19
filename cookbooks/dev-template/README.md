dev-template Cookbook
=====================
This is the default development template for all boxes spun up for meniscus development environments.

Requirements
------------

#### packages
- `none`

Attributes
----------

Usage
-----
#### dev-template::default

Just include `dev-template` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dev-template]"
  ]
}
```

License and Authors
-------------------
Licensed under the APLv2

Author: John Hopper
