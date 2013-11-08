name             'portal'
maintainer       'almutaz.el-kikhia@rackspace.com'
maintainer_email 'almutaz.el-kikhia@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures meniscus-portal'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.5'

%w{ apt }.each do |cb|
  depends cb
end

supports "ubuntu"