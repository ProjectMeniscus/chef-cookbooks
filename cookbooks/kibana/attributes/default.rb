# config attributes
default['kibana']['repo'] = "git://github.com/ProjectMeniscus/kibana"
default['kibana']['branch'] = "master"
default['kibana']['webserver'] = "nginx"
default['kibana']['installdir'] = "/opt/kibana"
default['kibana']['user'] = ''
default['kibana']['config_cookbook'] = 'kibana'
default['kibana']['webserver_hostname'] = node.name
default['kibana']['webserver_aliases'] = [node.ipaddress]
default['kibana']['webserver_listen'] = node.ipaddress
default['kibana']['webserver_port'] = 80

# elasticsearch attributes
default['kibana']['proxy_server'] = "localhost"
default['kibana']['proxy_port'] = 9200
default['kibana']['es_role'] = "elasticsearch_server"

#keystone attributes
default['kibana']['keystone_server'] = "localhost"
default['kibana']['keystone_port'] = 5000
