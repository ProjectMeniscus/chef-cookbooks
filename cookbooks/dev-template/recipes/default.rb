#
# Cookbook Name:: dev-template
# Recipe:: default
#
# Copyright 2013, Rackspace
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/iptables.rules" do
  source "etc/iptables.rules"
  owner "root"
  group "root"
  mode 00640
end

cookbook_file "/etc/network/if-pre-up.d/iptables" do
  source "etc/network/if-pre-up.d/iptables"
  owner "root"
  group "root"
  mode 00744
end

node_name = node.name
node_name_split = node_name.partition(".")
hostname = node_name_split[0]

template "/etc/hostname" do
    source "hostname.erb"
    variables(
      :hostname => hostname
    )

end

#apply new firewall rules immediately
bash "hostname_update" do
  user "root"
  code <<-EOH
    hostname -F /etc/hostname
  EOH
  action :run
end

#install ruby json support 
chef_gem "json" do
  action :install
end

#get authorized keys form private github repo
ruby_block "update authorized keys" do
  block do
    require 'rubygems'
  	require 'base64'
  	require 'json'
  	require 'net/https'

    github = data_bag_item("github_key_user", "auth")
    repo_owner = github["repo_owner"]
    repo_name = github["repo_name"]
    token = github["token"]
    github_uri = "https://api.github.com/repos/#{repo_owner}/#{repo_name}/contents/authorized_keys?access_token=#{token}"
    url = URI(github_uri)

    request = Net::HTTP::Get.new(url.request_uri,{"Accepts"=>"application/json"})
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    resp = http.start {|http| http.request(request) }
    Chef::Log.warn("\nGitHub API response_code #{resp.code}\n")

    if resp.code == "200"
  	  body = JSON.parse(resp.body)
  	  encoded_content = body['content']
  	  authorized_keys = Base64.decode64(encoded_content)
      node.set[:dev_template][:authorized_keys]  = authorized_keys
  	end

  end
end

if node[:dev_template][:authorized_keys] and not node[:dev_template][:authorized_keys].empty?
  Chef::Log.warn("\n\n***Updating authorized_keys***\n\n")
  template "/root/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    variables(
      :authorized_keys => node[:dev_template][:authorized_keys]
    )

  end
end


