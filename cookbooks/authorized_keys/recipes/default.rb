#
# Cookbook Name:: authorized_keys
# Recipe:: default
#
# Copyright 2013, Rackspace
#
# All rights reserved - Do Not Redistribute
#

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
      node.set[:authorized_keys][:authorized_keys]  = authorized_keys
    else
      raise "***Bad response code from GitHub API***"
  	end
  end
end

template "/root/.ssh/authorized_keys" do
  source "authorized_keys.erb"
  variables(
    :authorized_keys => node[:authorized_keys][:authorized_keys]
  )

end



