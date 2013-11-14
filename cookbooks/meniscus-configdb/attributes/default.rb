normal[:cloudpassage][:server_tag] = "#{node.environment}-configdb"
normal[:mmongo][:replset_name] = "#{node.environment}_configdb"
normal[:mmongo][:databag_name] = node.environment
normal[:mmongo][:databag_item] = "configdb"