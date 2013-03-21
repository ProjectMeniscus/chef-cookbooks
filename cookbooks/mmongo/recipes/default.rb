#
# Cookbook Name:: mmongo
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

apt_repository "10gen" do
  uri "http://downloads-distro.mongodb.org/repo/debian-sysvinit"
  distribution "dist"
  components ["10gen"]
  keyserver "keyserver.ubuntu.com"
  key "7F0CEB10"
end

execute "apt-get update" do
  command "apt-get update"
  action :run
end

ruby_block "edit iptables.rules" do
  block do
    rules = Chef::Util::FileEdit.new('/etc/iptables.rules')
    rules.insert_line_after_match('^## TCP$', 
        "-A TCP -p tcp -m tcp --dport #{node[:mmongo][:port]} -j ACCEPT")
    rules.write_file
  end
end

package "mongodb-10gen" do
  action :install
end

template "/etc/mongodb.conf" do
  source "mongodb.conf.erb"
  variables(
  	:mmongo => node[:mmongo]
  )
end

service "mongodb" do
  action :restart
end

chef_gem "mongo" do
  action :install
end

db_nodes = search(:node, "mmongo_replset_name:#{node[:mmongo][:replset_name]}")

if db_nodes.empty?

  ruby_block 'initialize replset' do
    block do
      require 'rubygems'
      require 'mongo'

      Chef::Log.debug("Initializing ReplSet #{node[:mmongo][:replset_name]}")

      #TODO(dmend): This should use dns instead of ip address
      db = Mongo::MongoClient.new('localhost', node[:mmongo][:port]).db('admin')
      cmd = BSON::OrderedHash.new
      cmd['replSetInitiate'] = { '_id' => node[:mmongo][:replset_name], 
                                 'members' => [ { '_id' => 0, 
                                                  'host' => [node[:ipaddress], 
                                                             node[:mmongo][:port]].join(':') } ] }
      db.command(cmd)
    end
  end

else

  ruby_block 'join replset' do
    block do
      require 'rubygems'
      require 'mongo'

      Chef::Log.debug("Joining ReplSet #{node[:mmongo][:replset_name]}")

      repl_node = db_nodes[0]
      client = Mongo::MongoReplicaSetClient.new([
                   [ repl_node[:ipaddress], 
                     repl_node[:mmongo][:port] ].join(':')
               ])      
      if !client.primary?
        primary = client.primary
        client = Mongo::MongoReplicaSetClient.new(["#{primary.join(':')}"])
      end

      config = client.db('local').collection('system.replset').find_one
      config['version'] += 1
      config['members'] << { '_id' => config['members'].size, 
                             'host' => [node[:ipaddress], node[:mmongo][:port]].join(':') }
      cmd = BSON::OrderedHash.new
      cmd['replSetReconfig'] = config
      db = client.db('admin')
      db.command(cmd)
    end
  end

end