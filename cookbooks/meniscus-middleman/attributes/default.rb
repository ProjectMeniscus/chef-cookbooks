normal[:cloudpassage][:server_tag] = "#{node.environment}-middleman"
normal[:middleman][:uwsgi_socket] = node[:rackspace][:private_ip]
normal[:middleman][:keystone_endpoint] = 'https://keystone-stg.projectmeniscus.org:35357/v2.0'

middleman_settings = data_bag_item(node.chef_environment, node[:middleman][:databag_item])
normal[:middleman][:auth_token] = ""
normal[:middleman][:elasticsearch_endpoint] = ""