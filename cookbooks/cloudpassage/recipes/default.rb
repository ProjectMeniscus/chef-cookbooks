#
# Cookbook Name:: cloudpassage
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

apt_repository "CloudPassage" do
  uri "http://packages.cloudpassage.com/debian"
  distribution "debian"
  components ["main"]
  key "http://packages.cloudpassage.com/cloudpassage.packages.key"
end

execute "apt-get update" do
  command "apt-get update"
  action :run
end

 package "cphalo" do
  action :install
end

#install/upgrade the daemon
package "cphalo" do
    action :upgrade
    notifies :restart, "service[cphalod]", :immediately
end

service "cphalod" do
    start_command "sudo /etc/init.d/cphalod start --daemon-key=#{node[:cloudpassage][:license_key]}"
    stop_command "service cphalod stop"
    status_command "service cphalod status"
    restart_command "service cphalod restart --daemon-key=#{node[:cloudpassage][:license_key]}"
    supports [:start, :stop, :status, :restart]
    #starts the service if it's not running and enables it to start at system boot time
    action [:enable, :start]
end

