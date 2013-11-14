# meniscus-configdb cookbook

Provisions a meniscus config db by running the base template and installing mongodb.              

# Attributes

* `normal[:cloudpassage][:server_tag] ` - `String` - sets the port for meniscus nodes to communicate with es
* `normal[:mmongo][:replset_name] ` - `String` - sets the port for elasticsearch to listen on

# Recipes

default - runs the base-template and mmongo recipes.

# Author

Author:: Steven Gonzales (<steven.gonzales@rackspace.com>)
