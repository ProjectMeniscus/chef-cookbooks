execute "apt-get update" do
  command "apt-get update"
  action :run
end

package "openjdk-7-jre-headless" do
  action :install
end

# Run a bash shell -  download, install and run ES
bash "install elasticsearch" do
     user "root"
     cwd "/tmp/"
     code <<-EOH
       wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.0.deb
       sudo dpkg -i elasticsearch-0.90.0.deb
	   sudo service elasticsearch start
     EOH
end

execute "install head plugin" do
  command "sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head"
  action :run
end

template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  variables(
    :cluster_name => node[:elasticsearch][:cluster_name],
    :node_name => node[:elasticsearch][:node_name], 
    :host_name => node[:elasticsearch][:host_name]
  )
end

#configure firewall rules to open a port for elasticsearch
ruby_block "edit iptables.rules" do
  block do
    es_port_rule = "-A TCP -p tcp -m tcp --dport #{node[:elasticsearch][:port]} -j ACCEPT"
    es_cluster_port_rule = "-A TCP -p tcp -m tcp --dport #{node[:elasticsearch][:cluster_port]} -j ACCEPT"

    ip_rules = Chef::Util::FileEdit.new('/etc/iptables.rules')
    ip_rules.insert_line_after_match('^## TCP$', es_port_rule)
    ip_rules.insert_line_after_match('^## TCP$', es_cluster_port_rule)
    ip_rules.write_file
  end
end

#apply new firewall rules immediately
bash "iptables-restore" do
  user "root"
  code <<-EOH
    iptables-restore /etc/iptables.rules
  EOH
  action :run
end

service "elasticsearch" do
  supports :restart => true
  action :enable
end