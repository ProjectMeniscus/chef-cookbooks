name             'meniscus-kibana'
maintainer       'Steven Gonzales'
maintainer_email 'steven.gonzales@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures meniscus-kibana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'base-template'
depends 'kibana'
depends 'meniscus-middleman'
