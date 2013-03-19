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
