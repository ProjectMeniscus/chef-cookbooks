#
# Cookbook Name:: portal
# Recipe:: default
#
# Copyright (C) 2013 Rackspace
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

#Add Meniscus-portal repository
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

#install meniscus-portal from repo
package "meniscus-portal" do
  action :install
  options "--force-yes"
end

  #upgrade meniscus-portal from repo
if node[:meniscus_portal][:auto_upgrade]
  package "meniscus-portal" do
    action :upgrade
    options "--force-yes"
  end
end

#Define meniscus-portal service
service "meniscus-portal" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

# chef solo?
unless Chef::Config[:solo]
  node.set['meniscus_portal']['syslog_bind_host'] = node[:rackspace][:private_ip]
  node.set['meniscus_portal']['zmq_bind_host'] = node[:rackspace][:private_ip]
end

#write portal config file
template "#{node['meniscus_portal']['config_dir']}/portal.conf" do
  source "portal.conf.erb"
  notifies :restart, "service[meniscus-portal]", :immediately
end
