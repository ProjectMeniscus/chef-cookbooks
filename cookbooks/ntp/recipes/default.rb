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

# Template is only meaningful on Debian family platforms
cookbook_file "/etc/cron.daily/ntpdate" do
  source "etc/cron.daily/ntpdate"
  owner "root"
  group "root"
  mode 00755
  action :create_if_missing 
end


# package 'ntp' do 
#   action :install
# end

# service 'ntp' do
#   supports :restart => true, :start => true, :stop => true, :status => true
#   action :enable
# end

# template '/etc/ntp.conf' do
#   source    'ntp.conf.erb'
#   notifies  :restart, 'service[ntp]'
# end
