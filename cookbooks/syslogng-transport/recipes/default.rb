#
# Cookbook Name:: syslogng-transport
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

include_recipe 'apt'
include_recipe 'hayrack'

#update the total window size by multiplying the maximum number of connections by the desired window size per connection
node.set[:syslogng_transport][:log_iw_size] = node[:syslogng_transport][:max_connections] * node[:syslogng_transport][:log_iw_size_per_connection]
node.set[:syslogng_transport][:log_fifo_size] = node[:syslogng_transport][:log_iw_size] * 2

apt_repository "syslog-ng" do
  uri "http://packages.madhouse-project.org/ubuntu"
  distribution "precise"
  components ["syslog-ng-3.5"]
  key "http://packages.madhouse-project.org/debian/archive-key.txt"
end

apt_preference "syslog-ng" do
  package_name "syslog-ng"
  pin "version 3.5"
  pin_priority "1001"
end

service "rsyslog" do
  action [ :disable, :stop ]
end

package "syslog-ng" do
  action :install
end

package "syslog-ng-mod-json" do
  action :install
end

template "/etc/syslog-ng/syslog-ng.conf" do
  source "syslog-ng.conf.erb"
  notifies :restart, "service[syslog-ng]"
end

template "/etc/syslog-ng/modules.conf" do
  source "modules.conf.erb"
  notifies :restart, "service[syslog-ng]"
end

service "syslog-ng" do
  supports :restart => true, :status => true
  action :enable
end

