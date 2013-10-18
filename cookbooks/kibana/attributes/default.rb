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
default['kibana']['es_server'] = "162.209.57.21"
default['kibana']['es_port'] = 9200
default['kibana']['es_role'] = "elasticsearch_server"

#keystone attributes
default['kibana']['keystone_server'] = "166.78.251.173"
default['kibana']['keystone_port'] = 5000

#attributes for kibana config.js
default['kibana']['config_template'] = "config.js.erb"
default['kibana']['kibana_index'] = "kibana-int"
default['kibana']['panel_name'] = "['histogram','map','pie','table','filtering','timepicker','text',
								    'fields','hits','dashcontrol','column','derivequeries','trends',
								    'bettermap','query','terms']"