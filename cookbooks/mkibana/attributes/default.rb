#cookbook attributes
default['kibana']['repo'] = "git://github.com/ProjectMeniscus/kibana"
default['kibana']['branch'] = "master"
default['kibana']['webserver'] = "tornado"
default['kibana']['installdir'] = "/var/www"
default['kibana']['es_server'] = "127.0.0.1"
default['kibana']['es_port'] = 9200
default['kibana']['es_role'] = "elasticsearch_server"
default['kibana']['user'] = 'root'
default['kibana']['config_template'] = "config.js.erb"
default['kibana']['config_index'] = "index.html.erb"
default['kibana']['config_cookbook'] = "mkibana"
default['kibana']['webserver_hostname'] = node.name
default['kibana']['webserver_aliases'] = [node.ipaddress]
default['kibana']['webserver_listen'] = node.ipaddress
default['kibana']['webserver_port'] = 80

#configuration kibana config.js
default['kibana']['kibana_index'] = "kibana-int"
default['kibana']['panel_name'] =[
      'histogram',
      'map',
      'pie',
      'table',
      'filtering',
      'timepicker',
      'text',
      'fields',
      'hits',
      'dashcontrol',
      'column',
      'derivequeries',
      'trends',
      'bettermap',
      'query',
      'terms'
    ]

#configure index
default['kibana']['index']['banner'] = "Project Meniscus - Dashboard"