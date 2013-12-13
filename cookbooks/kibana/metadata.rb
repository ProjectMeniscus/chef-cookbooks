name             'kibana'
maintainer       'Almutaz El-Kikhia'
maintainer_email 'almutaz.el-kikhia@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures kibana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'


depends 'git'
depends 'nginx'

supports "ubuntu"
supports "debian"
