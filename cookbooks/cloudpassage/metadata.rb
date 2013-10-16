name             'cloudpassage'
maintainer       'Rackspace'
maintainer_email 'steven.gonzales@rackspace.com'
license          'APLv2'
description      'Installs/Configures cloudpassage'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.4'

%w{ apt }.each do |cookbook|
  depends cookbook
end
