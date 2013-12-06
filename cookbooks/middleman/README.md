Middleman Cookbook
===============
Installs (Middleman)[https://github.com/ProjectMeniscus/middleman]

Requirements
------------
- apt


Attributes
----------

#### middleman::eleasticsearch

- `default[:middleman][:elasticsearch_endpoint]` - The ElasticSearch endpoint

#### middleman::logging

- `default[:middleman][:console]` - Print output to the consoe
- `default[:middleman][:logfile]` - Location of the log file
- `default[:middleman][:log_verbosity]` - How chatty you want the logger to be, WARN, INFO DEBUG, etc.

#### middleman::keystone

- `default[:middleman][:keystone_endpoint]` - The Keystone admin endpoint
- `default[:middleman][:insecure]` - Ignore SSL warnings
- `default[:middleman][:timeout]` - Time to wait for a response from Keystone
- `default[:middleman][:auth_token]` - The auth token for Keystone 
- `default[:middleman][:url_replacement]` - The string to replace in the URL (substitutes the tenant id here)

#### middleman::cache

- `default[:middleman][:cache_name]` - uWSGI cache name
- `default[:middleman][:ttl]` - Time to live setting (in seconds) for the uWSGI cache

#### middleman::uwsgi

- `default[:middleman][:uwsgi_socket]` - uWSGI socket address
- `default[:middleman][:uwsgi_protocol]` - Most likely this will be: http
- `default[:middleman][:uwsgi_processes]` - How many uWSGI processes to launch
- `default[:middleman][:uwsgi_cache_expires]` - uWSGI cache expiration (in seconds)
- `default[:middleman][:uwsgi_token_cache_items]` - uWSGI cache name

Author(s)
---------
Primary Author:

- Author:: Chad Lung (<chad.lung@rackspace.com>)
