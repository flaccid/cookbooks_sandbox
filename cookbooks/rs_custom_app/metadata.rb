name             'rs_custom_app'
maintainer       'Chris Fordham'
maintainer_email 'chris@xhost.com.au'
license          'Apache 2.0'
description      'Installs/Configures rs_custom_app'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "rightscale"
depends "repo"

recipe "rs_custom_app::update_code", "Test repo LWRP."