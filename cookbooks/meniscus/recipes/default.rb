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
include_recipe 'python'
include_recipe 'rabbitmq'
include_recipe 'liblognorm'
include_recipe 'libzmq'

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

#install meniscus from repo
package "meniscus" do
  action :install
  options "--force-yes"
end

#Define meniscus service
service "meniscus" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true
end

#create the meniscus configuration file
#use the db_ip array to create the list of mongo servers needed in the conf file
template "/etc/meniscus/meniscus.conf" do
    source "meniscus.conf.erb"
    owner "meniscus"
    group "meniscus"
    notifies :restart, "service[meniscus]"
end

template "/etc/meniscus/uwsgi.ini" do
    source "uwsgi.ini.erb"
    owner "meniscus"
    group "meniscus"
    notifies :restart, "service[meniscus]"
end
