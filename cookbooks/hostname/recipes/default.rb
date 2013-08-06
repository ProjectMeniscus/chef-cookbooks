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

#take only the hostname if the fqdn is assigned as the node name
node_name = node.name
node_name_split = node_name.partition(".")
hostname = node_name_split[0]

template "/etc/hostname" do
    source "hostname.erb"
    variables(
      :hostname => hostname
    )

end

#apply hostname immediately
bash "hostname_update" do
  user "root"
  code <<-EOH
    hostname -F /etc/hostname
  EOH
  action :run
end
