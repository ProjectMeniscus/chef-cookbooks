normal[:cloudpassage][:server_tag] = "#{node.environment}-configdb"
normal[:mmongo][:replset_name] = "#{node.environment}_configdb"
normal[:mmongo][:bind_host] = node[:rackspace][:private_ip]

mongo_settings = Chef::DataBagItem.load(node.chef_environment, "configdb")
normal[:mmongo][:auth_key] = mongo_settings["key"]
normal[:mmongo][:admin_user] = mongo_settings["admin_user"]
normal[:mmongo][:admin_pass] = mongo_settings["admin_pass"]
normal[:mmongo][:database] = "meniscus"
normal[:mmongo][:db_user] = mongo_settings["meniscus_user"]
normal[:mmongo][:db_pass] = mongo_settings["meniscus_pass"]

normal[:meetme_newrelic_plugin][:mongodb][:admin_username] = node[:mmongo][:admin_user]
normal[:meetme_newrelic_plugin][:mongodb][:admin_password] = node[:mmongo][:admin_pass]

normal[:meetme_newrelic_plugin][:mongodb][:database] = node[:mmongo][:database]
normal[:meetme_newrelic_plugin][:mongodb][:db_username] = node[:mmongo][:db_user]
normal[:meetme_newrelic_plugin][:mongodb][:db_password] = node[:mmongo][:db_pass]
