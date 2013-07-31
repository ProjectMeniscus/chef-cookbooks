authorized_keys Cookbook
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

Just include `authorized_keys` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[authorized_keys]"
  ]
}
```

License and Authors
-------------------
Licensed under the APLv2

Author: Steven Gonzales
