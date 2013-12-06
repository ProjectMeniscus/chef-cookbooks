#
# Cookbook Name:: middleman
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
include_recipe 'python'

# Add Meniscus-Middleman repository
apt_repository "ProjectMeniscus" do
  uri "http://debrepo.projectmeniscus.org"
  distribution "squeeze"
  components ["main"]
end

# Install middleman from repo
package "middleman" do
  action :install
  options "--force-yes"
end

#Define meniscus service
service "meniscus" do
  supports :restart => true
  action :enable
end

# Write hayrack config file
template "/etc/middleman/middleman.conf" do
  source "middleman.conf.erb"
  owner "middleman"
  group "middleman"
end

template "/etc/middleman/uwsgi.ini" do
    source "uwsgi.ini.erb"
    owner "middleman"
    group "middleman"
    notifies :restart, "service[middleman]"
end