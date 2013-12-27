name             'meniscus-elasticsearch'
maintainer       'Steven Gonzales'
maintainer_email 'steven.gonzales@rackspace.com'
license          'Apache 2.0'
description      'A wrapper cookbook used when deploying an elasticsearch cluster for the meniscus application'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.7'

depends 'base-template'
depends 'apt'
depends 'java'
depends 'elasticsearch'
depends 'meetme-newrelic-plugin'
