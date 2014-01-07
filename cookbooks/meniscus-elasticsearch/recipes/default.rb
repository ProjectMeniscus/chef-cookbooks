#
# Cookbook Name:: meniscus-elasticsearch
# Recipe:: default
#
# Copyright (C) 2013 Rackspace Hosting
# 
# All rights reserved - Do Not Redistribute
#

gem_package "json" do
  action :install
end

include_recipe "base-template"
include_recipe "blockstorage-lvm"
include_recipe "apt"
include_recipe "java"
include_recipe "elasticsearch::search_discovery"
include_recipe "elasticsearch"
include_recipe "elasticsearch::plugins"
include_recipe 'meetme-newrelic-plugin::elasticsearch'