#
# Cookbook Name:: meniscus
# Recipe:: default
#
# Copyright 2013, Rackspace
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

include_recipe 'apt'

apt_repository "rabbitmq" do
  uri "http://www.rabbitmq.com/debian/"
  distribution "testing"
  components ["main"]
  key "http://www.rabbitmq.com/rabbitmq-signing-key-public.asc"
end

 package "rabbitmq-server" do
  action :install
end


#Add Meniscus repository
apt_repository "ProjectMeniscus" do
  uri "http://debrepo.projectmeniscus.org"
  distribution "squeeze"
  components ["main"]
end

#update app definitions
execute "apt-get update" do
  command "apt-get update"
  action :run
end

#install make for librabbitmq
package "make" do
  action :install
end

#install C dependencies for pylognorm
package "libestr-dev" do
  action :install
end

package "libee-dev" do
  action :install
end

package "liblognorm-dev" do
  action :install
end


#install meniscus from repo
package "meniscus" do
  action :install
  options "--force-yes"
end

if node[:meniscus][:auto_upgrade]
  #upgrade meniscus from repo
  package "meniscus" do
    action :upgrade
    options "--force-yes"
  end
end

#Define meniscus service
service "meniscus" do
  supports :restart => true
  action :enable
end

node.set[:meniscus][:cluster_name] = node.chef_environment

#if this is the first worker for the meniscus cluster
#set the default python app in an environmental variable 
#and make the worker a coordinator
coordinator_uri = node[:meniscus][:coordinator_uri]
if node[:meniscus][:personality] == "cbootstrap"
  ENV["WORKER_PERSONA"] ="meniscus.personas.cbootstrap.app"
  node.set[:meniscus][:personality] = "coordinator"
  coordinator_uri = node[:rackspace][:private_ip] 
end

#search chef server for the coordinator_db database nodes
coordinator_db_nodes = search(:node, "mmongo_replset_name:#{node[:meniscus][:coordinator_db_cluster_name]}")
#create a new array containg only the ip_address:port_no for each of the database nodes
coordinator_db_ip = []
coordinator_db_nodes.each do |coordinator_db_node|
  coordinator_db_ip.push([coordinator_db_node[:rackspace][:private_ip], coordinator_db_node[:mmongo][:port]].join(':'))
  node.set[:meniscus][:coordinator_db_servers] = coordinator_db_ip.join(',')
end

#search chef server for the short_term_store database nodes
short_term_store_nodes = search(:node, "mmongo_replset_name:#{node[:meniscus][:short_term_store_cluster_name]}")
#create a new array containg only the ip_address:port_no for each of the database nodes
short_term_store_ip = []
short_term_store_nodes.each do |short_term_store_node|
  short_term_store_ip.push([short_term_store_node[:rackspace][:private_ip], short_term_store_node[:mmongo][:port]].join(':'))
  node.set[:meniscus][:short_term_store_servers] = short_term_store_ip.join(',')
end

coordinator_db_settings = data_bag_item(node.chef_environment, node[:meniscus][:coordinator_db_databag_item])
coordinator_db_username = coordinator_db_settings["meniscus_user"]
coordinator_db_password = coordinator_db_settings["meniscus_pass"]

puts "**databage items:**"
puts coordinator_db_settings["meniscus_user"]
puts coordinator_db_username 
puts coordinator_db_settings["meniscus_pass"]
puts coordinator_db_password

short_term_store_username = nil
short_term_store_password = nil
if node[:meniscus][:short_term_store_databag_item]
  short_term_store_settings = data_bag_item(node.chef_environment, node[:meniscus][:short_term_store_databag_item])
  short_term_store_username = short_term_store_settings["meniscus_user"]
  short_term_store_password = short_term_store_settings["meniscus_pass"]
end

#create the meniscus configuration file
#use the db_ip array to create the list of mongo servers needed in the conf file
template "/etc/meniscus/meniscus.conf" do
    source "meniscus.conf.erb"
    variables(
      :log_debug => node[:meniscus][:log_debug],
      :log_file => node[:meniscus][:log_file],
      :coordinator_db_adapter_name => node[:meniscus][:coordinator_db_adapter_name],
      :coordinator_db_active => node[:meniscus][:coordinator_db_active],
      :coordinator_db_servers => node[:meniscus][:coordinator_db_servers],
      :coordinator_db_database => node[:meniscus][:coordinator_db_database],
      :coordinator_db_username => coordinator_db_username,
      :coordinator_db_password => coordinator_db_password,
      :short_term_store_adapter_name => node[:meniscus][:short_term_store_adapter_name],
      :short_term_store_active => node[:meniscus][:short_term_store_active],
      :short_term_store_servers => node[:meniscus][:short_term_store_servers],
      :short_term_store_database => node[:meniscus][:short_term_store_database],
      :short_term_store_username => short_term_store_username,
      :short_term_store_password => short_term_store_password,
      :data_sinks_valid_sinks => node[:meniscus][:data_sinks_valid_sinks],
      :data_sinks_default_sink => node[:meniscus][:data_sinks_default_sink],
      :default_sink_adapter_name => node[:meniscus][:default_sink_adapter_name],
      :default_sink_active => node[:meniscus][:default_sink_active], 
      :default_sink_servers => node[:meniscus][:default_sink_servers],
      :default_sink_index => node[:meniscus][:default_sink_index],
      :default_sink_bulk_size => node[:meniscus][:default_sink_bulk_size],
      :hdfs_sink_hostname => node[:meniscus][:hdfs_sink_hostname],
      :hdfs_sink_port => node[:meniscus][:hdfs_sink_port],
      :hdfs_sink_user_name => node[:meniscus][:hdfs_sink_user_name],
      :hdfs_sink_base_directory => node[:meniscus][:hdfs_sink_base_directory],
      :hdfs_sink_transaction_expire => node[:meniscus][:hdfs_sink_transaction_expire],
      :hdfs_sink_transfer_frequency => node[:meniscus][:hdfs_sink_transfer_frequency],
      :celery_broker_url => node[:meniscus][:celery_broker_url],
      :celery_concurrency => node[:meniscus][:celery_concurrency],
      :celery_disable_rate_limits => node[:meniscus][:celery_disable_rate_limits],
      :celery_task_serializer => node[:meniscus][:celery_task_serializer],
      :uwsgi_cache_expires => node[:meniscus][:uwsgi_cache_expires],
      :schema_dir => node[:meniscus][:json_schema_dir],
      :liblognorm_rules_dir => node[:meniscus][:liblognorm_rules_dir],
      :default_ifname => node[:meniscus][:default_ifname ]
    )
    notifies :restart, "service[meniscus]", :immediately
end


template "/etc/meniscus/meniscus-paste.ini" do
    source "meniscus-paste.ini.erb"
    notifies :restart, "service[meniscus]", :immediately
end

template "/etc/meniscus/uwsgi.ini" do
    source "uwsgi.ini.erb"
    variables(
      :uwsgi_socket => "#{node[:rackspace][:private_ip]}:#{node[:meniscus][:port]}",
      :pynopath => node[:meniscus][:pynopath],
      :config_file => node[:meniscus][:config_file],
      :uwsgi_protocol => node[:meniscus][:uwsgi_protocol],
      :uwsgi_processes => node[:meniscus][:uwsgi_processes],
      :uwsgi_paste_file => node[:meniscus][:uwsgi_paste_file],
      :uwsgi_config_cache_items => node[:meniscus][:uwsgi_config_cache_items],
      :uwsgi_tenant_cache_items => node[:meniscus][:uwsgi_tenant_cache_items],
      :uwsgi_token_cache_items => node[:meniscus][:uwsgi_token_cache_items]
      )
    notifies :restart, "service[meniscus]", :immediately
end

#install ruby json support 
chef_gem "json" do
  action :install
end

#install ruby uuid support 
chef_gem "uuid" do
  action :install
end

if not node[:meniscus][:paired]
  #give the new worker its configuration by making an http POST
  ruby_block "post configuration" do
    block do
      require 'rubygems'
      require 'net/http'
      require 'json'
      require 'uuid'
      
      uuid = UUID.new
      #build the body of the post as a json string
      body = {
        "pairing_configuration" => {
          "api_secret" => uuid.generate,
          "coordinator_uri"  =>  "http://#{coordinator_uri}:#{node[:meniscus][:port]}/v1",
          "personality"  =>  node[:meniscus][:personality]
        }
      }.to_json

      print body

      #build the POST request objet
      req = Net::HTTP::Post.new("/v1/pairing/configure", initheader = {'Content-Type' =>'application/json'})
      req.body = body

      #make the POST request
      response = Net::HTTP.new(node[:rackspace][:private_ip], node[:meniscus][:port]).start {|http| http.request(req) }
      puts "Response #{response.code} #{response.message}:
            #{response.body}"
      node.set[:meniscus][:paired] = true

    end
  end
end
