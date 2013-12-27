name             'meniscus'
maintainer       'Rackspace'
maintainer_email 'steven.gonzales@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures Meniscus nodes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.3'

depends 'apt'
depends 'python'
depends 'rabbitmq'
depends 'liblognorm'
depends 'libzmq'
