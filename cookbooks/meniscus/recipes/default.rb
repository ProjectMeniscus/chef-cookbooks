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

#upgrade meniscus from repo
package "meniscus" do
  action :upgrade
  options "--force-yes"
end

#Define meniscus service
service "meniscus" do
  supports :restart => true
  action :enable
end

#configure firewall rules to open ports for meniscus
ruby_block "edit iptables.rules" do
  block do
    meniscus_port_rule = "-A TCP -p tcp -m tcp --dport #{node[:meniscus][:port]} -j ACCEPT"
    syslog_port_rule = "-A TCP -p tcp -m tcp --dport #{node[:meniscus][:syslog_port]} -j ACCEPT"

    ip_rules = Chef::Util::FileEdit.new('/etc/iptables.rules')
    ip_rules.insert_line_after_match('^## TCP$', meniscus_port_rule)
    ip_rules.write_file

    if ["worker"].include? node[:meniscus][:personality]
      ip_rules.insert_line_after_match('^## TCP$', syslog_port_rule)
      ip_rules.write_file
    end

  end
end

#apply new firewall rules immediately
bash "iptables-restore" do
  user "root"
  code <<-EOH
    iptables-restore /etc/iptables.rules
  EOH
  action :run
end

#if this is the first worker for the meniscus cluster
#set the default python app in an environmental variable 
#and make the worker a coordinator
if node[:meniscus][:personality] == "cbootstrap"
  ENV["WORKER_PERSONA"] ="meniscus.personas.cbootstrap.app"
  node.set[:meniscus][:personality] = "coordinator"
end

#search chef server for the coordinator_db database nodes
coordinator_db_nodes = search(:node, "mmongo_replset_name:#{node[:meniscus][:coordinator_db_cluster_name]}")
#create a new array containg only the ip_address:port_no for each of the database nodes
coordinator_db_ip = []
coordinator_db_nodes.each do |coordinator_db_node|
  coordinator_db_ip.push([coordinator_db_node[:ipaddress], coordinator_db_node[:mmongo][:port]].join(':'))
  node.set[:meniscus][:coordinator_db_servers] = coordinator_db_ip.join(',')
end

#search chef server for the short_term_store database nodes
short_term_store_nodes = search(:node, "mmongo_replset_name:#{node[:meniscus][:short_term_store_cluster_name]}")
#create a new array containg only the ip_address:port_no for each of the database nodes
short_term_store_ip = []
short_term_store_nodes.each do |short_term_store_node|
  short_term_store_ip.push([short_term_store_node[:ipaddress], short_term_store_node[:mmongo][:port]].join(':'))
  node.set[:meniscus][:short_term_store_servers] = short_term_store_ip.join(',')
end


#create the meniscus configuration file
#use the db_ip array to create the list of mongo servers needed in the conf file
template "/etc/meniscus/meniscus.conf" do
    source "meniscus.conf.erb"
    variables(
      :log_debug => node[:meniscus][:log_debug],
      :log_file => node[:meniscus][:log_file],
      :coordinator_db_adapter_name => node[:meniscus][:coordinator_db_adapter_name],
      :coordinator_db_servers => node[:meniscus][:coordinator_db_servers],
      :coordinator_db_database => node[:meniscus][:coordinator_db_database],
      :coordinator_db_username => node[:meniscus][:coordinator_db_username],
      :coordinator_db_password => node[:meniscus][:coordinator_db_password],
      :short_term_store_adapter_name => node[:meniscus][:short_term_store_adapter_name],
      :short_term_store_servers => node[:meniscus][:short_term_store_servers],
      :short_term_store_database => node[:meniscus][:short_term_store_database],
      :short_term_store_username => node[:meniscus][:short_term_store_username],
      :short_term_store_password => node[:meniscus][:short_term_store_password],
      :data_sinks_valid_sinks => node[:meniscus][:data_sinks_valid_sinks],
      :data_sinks_default_sink => node[:meniscus][:data_sinks_default_sink],
      :default_sink_adapter_name => node[:meniscus][:default_sink_adapter_name], 
      :default_sink_servers => node[:meniscus][:default_sink_servers],
      :default_sink_index => node[:meniscus][:default_sink_index],
      :hdfs_sink_hostname => node[:meniscus][:hdfs_sink_hostname],
      :hdfs_sink_port => node[:meniscus][:hdfs_sink_port],
      :hdfs_sink_user_name => node[:meniscus][:hdfs_sink_user_name],
      :hdfs_sink_base_directory => node[:meniscus][:hdfs_sink_base_directory],
      :hdfs_sink_transaction_expire => node[:meniscus][:hdfs_sink_transaction_expire],
      :hdfs_sink_transfer_frequency => node[:meniscus][:hdfs_sink_transfer_frequency],
      :celery_broker_url => node[:meniscus][:celery_broker_url],
      :celery_concurrency => node[:meniscus][:celery_concurrency],
      :celery_disbale_rate_limits => node[:meniscus][:celery_disbale_rate_limits],
      :celery_task_serializer => node[:meniscus][:celery_task_serializer],
      :schema_dir => node[:meniscus][:json_schema_dir]
    )
    notifies :restart, "service[meniscus]", :immediately
end


template "/etc/meniscus/meniscus-paste.ini" do
    source "meniscus-paste.ini.erb"
    notifies :restart, "service[meniscus]", :immediately
end


#assign the node to a coordinator
if not node[:meniscus][:coordinator_ip] or node[:meniscus][:coordinator_ip].empty?
  ruby_block "assign coordinator" do
    block do
      #search chef-server for a list of all coordinators
      coordinator_nodes = search(:node, "meniscus_personality:coordinator AND meniscus_cluster_name:#{node[:meniscus][:cluster_name]}")
      if coordinator_nodes.count == 0
        node.set[:meniscus][:coordinator_ip] = node[:ipaddress]

      else
        coordinator_info = Array.new

        coordinator_nodes.each do |coordinator|

          #get the coordinator's ip address
          coordinator_ip = coordinator[:ipaddress]
          #search for a list of nodes that are assigned to this coordinator
          member_nodes = search(:node, "meniscus_coordinator_ip:#{coordinator_ip}")

          #Create a stats item that list the coordinator's ip address and the number of member nodes.
          #A node will only assign itself as its coordinator if it is the first node on the grid.
          #if there are other coordinators on the grid, the ndoe will not include its info in the list
          unless coordinator_nodes.count > 1 and coordinator_ip == node[:ipaddress]   
            coordinator_info.push({:coordinator_ip => coordinator_ip, :node_count => member_nodes.count}) 
          end
        end

        #sort the coordinator array by the number of nodes assigned, 
        #and then select the first coordinator in the array
        coordinator_info = coordinator_info.sort_by { |hsh| hsh[:node_count] }
        puts coordinator_info
        selected_coordinator = coordinator_info[0]
        node.set[:meniscus][:coordinator_ip] = selected_coordinator[:coordinator_ip]

      end

    end
  end
end

#install ruby json support 
chef_gem "json" do
  action :install
end

#install ruby uuid support 
chef_gem "uuid" do
  action :install
end

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
        "coordinator_uri"  =>  "http://#{node[:meniscus][:coordinator_ip]}:#{node[:meniscus][:port]}/v1",
        "personality"  =>  node[:meniscus][:personality]
      }
    }.to_json

    print body

    #build the POST request objet
    req = Net::HTTP::Post.new("/v1/pairing/configure", initheader = {'Content-Type' =>'application/json'})
    req.body = body

    #make the POST request
    response = Net::HTTP.new(node[:ipaddress], node[:meniscus][:port]).start {|http| http.request(req) }
    puts "Response #{response.code} #{response.message}:
          #{response.body}"

  end
end
