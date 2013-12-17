#
# Cookbook Name:: meniscus-middleman
# Recipe:: default
#
# Copyright (C) 2013 Chad Lung
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

middleman_settings = data_bag_item(node.chef_environment, node[:middleman][:databag_item])
node.set[:middleman][:auth_token] = middleman_settings[:auth_token]

haproxy_nodes = search(:node, "chef_environment:#{node.environment} AND meniscus_personality:haproxy")
if haproxy_nodes.length() > 0
	haproxy_node = haproxy_nodes[0]
	haproxy_ip = haproxy_node[:rackspace][:private_ip]
	haproxy_port = haproxy_node[:haproxy][:incoming_port]
	node.set[:middleman][:elasticsearch_endpoint] = "http://#{haproxy_ip}:#{haproxy_port}/"
end

include_recipe 'base-template'
include_recipe 'middleman'
