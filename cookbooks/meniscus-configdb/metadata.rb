name             'meniscus-configdb'
maintainer       'Steven Gonzales'
maintainer_email 'steven.gonzales@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures meniscus-configdb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu'
depends 'base-template'
depends 'mmongo'
depends 'meetme-newrelic-plugin'