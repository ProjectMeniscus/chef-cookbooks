default['kibana']['repo'] = "git://github.com/ProjectMeniscus/kibana"
default['kibana']['branch'] = "master"
default['kibana']['webserver'] = "nginx"
default['kibana']['installdir'] = "/opt/kibana"
default['kibana']['es_server'] = "162.209.9.177"
default['kibana']['es_port'] = 9200
default['kibana']['es_role'] = "elasticsearch_server"
default['kibana']['user'] = ''
default['kibana']['config_cookbook'] = 'kibana'
default['kibana']['webserver_hostname'] = node.name
default['kibana']['webserver_aliases'] = [node.ipaddress]
default['kibana']['webserver_listen'] = node.ipaddress
default['kibana']['webserver_port'] = 80

#attributes for kibana config.js
default['kibana']['config_template'] = "config.js.erb"
default['kibana']['kibana_index'] = "logs"
default['kibana']['panel_name'] = "['histogram','map','pie','table','stringquery','sort',
                                    'timepicker','text','fields','hits','dashcontrol',
                                    'column','derivequeries','trends','bettermap']"

#attributes for index.html
default['kibana']['config_index'] = "index.html.erb"
default['kibana']['index']['banner'] = "Project Meniscus - Dashboard"

#attributes for default dashboard
default['kibana']['config_dashboard'] = "default.json.erb"
default['kibana']['dashboard']['data_center'] = "Meniscus (ORD) - Kibana"
