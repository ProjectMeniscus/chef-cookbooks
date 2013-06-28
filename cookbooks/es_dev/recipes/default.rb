execute "apt-get update" do
  command "apt-get update"
  action :run
end

execute "install openjdk-7-jre-headless" do
  command "sudo apt-get install openjdk-7-jre-headless -y"
  action :run
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

# configure elasticsearch.yaml
template "/etc/elasticsearch" do
  source "elasticsearch.yaml.erb"
  owner 'root' and mode 0755
end

# configure elasticsearch.yaml
template "/etc/elasticsearch" do
  source "elasticsearch.yaml.erb"
  owner 'root' and mode 0755
end

# Create service
template "/etc/init.d/elasticsearch" do
  source "elasticsearch.init.erb"
  owner 'root' and mode 0755
end

service "elasticsearch" do
  supports :status => true, :restart => true
  action [ :enable ]
end

# Create file with ES environment variables
#
template "elasticsearch-env.sh" do
  path   "#{node.elasticsearch[:path][:conf]}/elasticsearch-env.sh"
  source "elasticsearch-env.sh.erb"
  owner node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755

  notifies :restart, 'service[elasticsearch]'
end

# Create ES config file
#
template "elasticsearch.yml" do
  path   "#{node.elasticsearch[:path][:conf]}/elasticsearch.yml"
  source "elasticsearch.yml.erb"
  owner node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755

  notifies :restart, 'service[elasticsearch]'
end
