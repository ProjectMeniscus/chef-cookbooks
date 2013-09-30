#
# Cookbook Name:: mkibana
# Recipe:: mkibana
#
# Copyright 2013, Rackspace
#
# All rights reserved - Do Not Redistribute
#

# include_recipe 'newrelic'
include_recipe 'git'

# set the elasticsearch server
unless Chef::Config[:solo]
  es_server_results = search(:node, "roles:#{node['kibana']['es_role']} AND chef_environment:#{node.chef_environment}")
  unless es_server_results.empty?
    node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
  end
end

#set the kibana user, if not set use webserver name
if node['kibana']['user'].empty?
  webserver = node['kibana']['webserver']
  kibana_user = "#{node[webserver]['user']}"
else
  kibana_user = node['kibana']['user']
end

#create install directory for kibana
directory node['kibana']['installdir'] do
  owner kibana_user
  mode "0755"
end

#git install kibana to install directory
git "#{node['kibana']['installdir']}/#{node['kibana']['branch']}" do
  repository node['kibana']['repo']
  reference node['kibana']['branch']
  action :sync
  user kibana_user
end

#write config.js file
template "#{node['kibana']['installdir']}/#{node['kibana']['branch']}/config.js" do
  source node['kibana']['config_template']
  cookbook node['kibana']['config_cookbook']
  mode "0750"
  user kibana_user
end

#write index.html file
template "#{node['kibana']['installdir']}/#{node['kibana']['branch']}/index.html" do
  source node['kibana']['config_index']
  cookbook node['kibana']['config_cookbook']
  mode "0750"
  user kibana_user
end
