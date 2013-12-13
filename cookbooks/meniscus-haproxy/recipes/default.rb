#
# Cookbook Name:: meniscus-haproxy
# Recipe:: default
#
# Copyright (C) 2013 Rackspace Hosting
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

#search chef server for the elasticsearch nodes
es_nodes = search(:node, "elasticsearch_cluster_name:#{node.environment}")

#create a dictionary defining entries to add the  
#es servers as haproxy member nodes
haproxy_members = []
es_nodes.each do |es_node|
  haproxy_members.push({
    "hostname" => es_node[:hostname],
    "ipaddress" => es_node[:rackspace][:private_ip],
    "port" => es_node[:elasticsearch][:port]  
  })
end

node.set['haproxy']['members'] = haproxy_members

include_recipe 'base-template'
include_recipe 'haproxy'