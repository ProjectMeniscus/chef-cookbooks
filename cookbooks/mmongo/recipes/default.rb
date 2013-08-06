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

#node[:rackspace][:private_ip]
apt_repository "10gen" do
  uri "http://downloads-distro.mongodb.org/repo/ubuntu-upstart"
  distribution "dist"
  components ["10gen"]
  keyserver "keyserver.ubuntu.com"
  key "7F0CEB10"
end

execute "apt-get update" do
  command "apt-get update"
  action :run
end

package "mongodb-10gen" do
  action :install
end

chef_gem "mongo" do
  action :install
  version '1.8.6'
end

mongo_settings = data_bag_item(node.chef_environment, node[:mmongo][:databag_item])
key = mongo_settings["key"]

template node[:mmongo][:keyfile] do
    source "keyfile.erb"
    owner "mongodb"
    mode "0600"
    variables(
      :key => key
    )
end

node.set[:mmongo][:replset_name] = mongo_settings["replset_name"]
#searching for existing nodes in replset, only possible with Chef Server, not with Chef Solo
if Chef::Config[:solo]
  Chef::Log.warn("This recipe requires Chef Server to join replsets. This node will start as new replset")
  db_nodes = []
  db_ip = []
else
  db_nodes = search(:node, "mmongo_replset_name:#{node[:mmongo][:replset_name]}")
  db_ip = []
  db_nodes.each do |db_node|
    db_ip.push(db_node[:rackspace][:private_ip])
  end

end


if db_nodes.empty?

  db_nodes = [node]

  template "/etc/mongodb.conf" do
    source "mongodb.conf.erb"
    variables(
      :mmongo => node[:mmongo]
    )

  end

  ruby_block "remove auth from conf" do
    block do
      rules = Chef::Util::FileEdit.new('/etc/mongodb.conf')
      rules.search_file_delete_line('keyFile')
      rules.write_file
    end
  end

  service "mongodb" do
    action :restart
  end

  execute "wait" do
    command "sleep 120;"
    action :run
  end

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
                                                  'host' => [node[:rackspace][:private_ip], 
                                                             node[:mmongo][:port]].join(':') } ] }
      db.command(cmd)
    end
  end

  execute "wait" do
    command "sleep 120;"
    action :run
  end

  ruby_block 'add users' do
    block do
      require 'rubygems'
      require 'mongo'

      Chef::Log.debug("Adding users")
      client = Mongo::MongoClient.new('localhost', node[:mmongo][:port])  
     
      db = client.db('admin')
      db.add_user(mongo_settings["admin_user"], mongo_settings["admin_pass"])

      db = client.db('meniscus')
      db.add_user(mongo_settings["meniscus_user"], mongo_settings["meniscus_pass"])

    end
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

elsif not db_ip.include? node[:rackspace][:private_ip]

  template "/etc/mongodb.conf" do
    source "mongodb.conf.erb"
    variables(
      :mmongo => node[:mmongo]
    )

  end

  service "mongodb" do
    action :restart
  end

  execute "wait" do
    command "sleep 60;"
    action :run
  end

  ruby_block 'join replset' do
    block do
      require 'rubygems'
      require 'mongo'

      Chef::Log.debug("Joining ReplSet #{node[:mmongo][:replset_name]}")

      repl_node = db_nodes[0]
      client = Mongo::MongoReplicaSetClient.new([
                   [ repl_node[:rackspace][:private_ip], 
                     repl_node[:mmongo][:port] ].join(':')
               ])

      client.add_auth("admin", mongo_settings["admin_user"], mongo_settings["admin_pass"])
      client.apply_saved_authentication()

      if !client.primary?
        primary = client.primary
        client = Mongo::MongoReplicaSetClient.new(["#{primary.join(':')}"])
      end

      config = client.db('local').collection('system.replset').find_one
      config['version'] += 1
      config['members'] << { '_id' => config['members'].size, 
                             'host' => [node[:rackspace][:private_ip], node[:mmongo][:port]].join(':') }
      cmd = BSON::OrderedHash.new
      cmd['replSetReconfig'] = config
      db = client.db('admin')
      db.command(cmd)

    end
  end

end
