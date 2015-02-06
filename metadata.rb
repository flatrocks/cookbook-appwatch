name             'appwatch'
maintainer       'TRI'
maintainer_email 'tom@triresources.com'
license          'All rights reserved'
description      'Appwatch service for logwwatch with associated python helper class'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'perl', '~> 1.2'
depends 'logwatch', '~> 1.1'

supports 'ubuntu', '>= 14.04'
