meniscus Cookbook
=================

This cookbook installs Meniscus node instances.  The default recipe installs a worker node.

Requirements
------------

#### packages
- `python` - Meniscus is written in Python.

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
