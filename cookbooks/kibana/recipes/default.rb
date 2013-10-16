#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2013, John E. Vincent
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"
include_recipe "git"
include_recipe "nginx"

unless Chef::Config[:solo]
  es_server_results = search(:node, "roles:#{node['kibana']['es_role']} AND chef_environment:#{node.chef_environment}")
  unless es_server_results.empty?
    node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
  end
end

if node['kibana']['user'].empty?
  webserver = node['kibana']['webserver']
  kibana_user = "#{node[webserver]['user']}"
else
  kibana_user = node['kibana']['user']
end

directory node['kibana']['installdir'] do
  owner kibana_user
  mode "0755"
  action :create
end

git "#{node['kibana']['installdir']}/#{node['kibana']['branch']}" do
  repository node['kibana']['repo']
  reference node['kibana']['branch']
  action :sync
  user kibana_user
end

link "#{node['kibana']['installdir']}/current" do
  to "#{node['kibana']['installdir']}/#{node['kibana']['branch']}/src"
end

template "#{node['kibana']['installdir']}/current/config.js" do
  source node['kibana']['config_template']
  cookbook node['kibana']['config_cookbook']
  mode "0750"
  user kibana_user
end

#write index.html file
template "#{node['kibana']['installdir']}/current/index.html" do
  source node['kibana']['config_index']
  cookbook node['kibana']['config_cookbook']
  mode "0750"
  user kibana_user
end

#write default dashboard file
template "#{node['kibana']['installdir']}/current/app/dashboards/default.json" do
  source node['kibana']['config_dashboard']
  cookbook node['kibana']['config_cookbook']
  mode "0750"
  user kibana_user
end

include_recipe "kibana::#{node['kibana']['webserver']}"
