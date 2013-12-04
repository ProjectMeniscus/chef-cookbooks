#
# Cookbook Name:: hayrack
# Recipe:: default
#
# Copyright (C) 2013 Rackspace
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

#Add Meniscus-portal repository
apt_repository "ProjectMeniscus" do
  uri "http://debrepo.projectmeniscus.org"
  distribution "squeeze"
  components ["main"]
end

#install meniscus-portal from repo
package "hayrack" do
  action :install
  options "--force-yes"
end

#write portal config file
template "/etc/hayrack/hayrack.conf" do
  source "hayrack.conf.erb"
  owner "hayrack"
  group "hayrack"
end