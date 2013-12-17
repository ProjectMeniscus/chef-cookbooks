# middleman.conf attributes
default[:middleman][:elasticsearch_endpoint] = 'http://localhost:9200/'

default[:middleman][:console] = true
default[:middleman][:logfile] = '/var/log/middleman/middleman.log'
default[:middleman][:log_verbosity] = 'DEBUG'

default[:middleman][:keystone_endpoint] = 'https://localhost:35357/v2.0'
default[:middleman][:insecure] = true
default[:middleman][:timeout] = 5
default[:middleman][:auth_token] = '123abc'
default[:middleman][:url_replacement] = '_all'

default[:middleman][:cache_name] = 'cache-token'
default[:middleman][:ttl] = 3600

# uwsgi.ini attributes
default[:middleman][:uwsgi_socket] = '0.0.0.0:9200'
default[:middleman][:uwsgi_protocol] = 'http'
default[:middleman][:uwsgi_processes] = 4
default[:middleman][:uwsgi_cache_expires] = 3600
default[:middleman][:uwsgi_token_cache_items] = 1000

default[:middleman][:request_timeout] = 15

default[:middleman][:pynopath] = "/usr/share/middleman/lib/python"
default[:middleman][:config_file] = "/etc/middleman/middleman.conf"
