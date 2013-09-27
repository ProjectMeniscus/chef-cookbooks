#
# Cookbook Name:: meniscus-logrotate
# Recipe:: default
#
# Copyright 2013, Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

logrotate_app "meniscus" do
  cookbook "logrotate"
  path node[:meniscus][:log_file]
  frequency node[:logrotate_app][:meniscus][:frequency]
  rotate node[:logrotate_app][:meniscus][:rotate]
  options node[:logrotate_app][:meniscus][:options]
  rotate node[:logrotate_app][:meniscus][:rotate]
  create node[:logrotate_app][:meniscus][:create]
  size node[:logrotate_app][:meniscus][:size]
end
