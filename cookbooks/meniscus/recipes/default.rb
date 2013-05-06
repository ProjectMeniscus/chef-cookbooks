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
include_recipe "python::#{node['python']['install_method']}"
include_recipe "python::pip"

%w(falcon wsgiref pymongo requests 
  iso8601 eventlet oslo.config uWSGI
  https://github.com/ProjectMeniscus/portal/blob/release/Meniscus%20Portal-0.1.tar.gz?raw=true).each do |pkg|
  python_pip pkg do
    action :install
  end
end

remote_file "/tmp/meniscus_0.1.302-1_all.deb" do
  source "http://50.56.176.80:8000/meniscus_0.1.302-1_all.deb"
  notifies :run, "bash[install_program]", :immediately
end

bash "install_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    dpkg -i /tmp/meniscus_0.1.302-1_all.deb
  EOH
  action :nothing
end

ruby_block "edit iptables.rules" do
  block do
    meniscus_port_rule = "-A TCP -p tcp -m tcp --dport #{node[:meniscus][:port]} -j ACCEPT"
    ip_rules = Chef::Util::FileEdit.new('/etc/iptables.rules')
    ip_rules.search_file_delete_line(meniscus_port_rule)
    ip_rules.insert_line_after_match('^## TCP$', meniscus_port_rule)
    ip_rules.write_file
  end
end

bash "iptables-restore" do
  user "root"
  code <<-EOH
    iptables-restore /etc/iptables.rules
  EOH
  action :nothing
end

ENV["WORKER_PERSONA"] ="meniscus.personas.cbootstrap.app"

if ["cbootstrap", "coordinator"].include? node[:meniscus][:personality]
	db_nodes = search(:node, "mmongo_replset_name:rs0")
	
elsif ["storage"].include? node[:meniscus][:perosnality]
	db_nodes = search(:node, "mmongo_replset_name:rs0")

else 
	db_nodes = []
end

db_ip = []
db_nodes.each do |db_node|
	db_ip.push([db_node[:ipaddress], db_node[:mmongo][:port]].join(':'))
end

template "/etc/meniscus/meniscus.conf" do
    source "meniscus.conf.erb"
    variables(
      :mongo_servers => "198.61.167.194:27017"
    )
end

service "meniscus" do
	action :restart
end