#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "ntpdate" do
  only_if { node['platform'] == "debian" or node['platform'] == "ubuntu" }
end


template "/etc/cron.daily/ntpdate" do
  source "ntpdate.erb"
  owner "root"
  group "root"
  mode 00755
end