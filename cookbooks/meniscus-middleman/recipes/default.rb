#
# Cookbook Name:: meniscus-middleman
# Recipe:: default
#
# Copyright (C) 2013 Chad Lung
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

middleman_settings = data_bag_item(node.chef_environment, node[:middleman][:databag_item])
node.set[:middleman][:auth_token] = middleman_settings[:auth_token]

include_recipe 'base-template'
include_recipe "middleman"
