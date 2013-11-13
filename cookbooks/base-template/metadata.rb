name             'base-template'
maintainer       'Steven Gonzales'
maintainer_email 'steven.gonzales@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures base-template'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'authorized_keys'
depends 'cloudpassage'
depends 'newrelic'
depends 'ntp'
