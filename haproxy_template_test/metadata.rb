name             'haproxy_template_test'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures haproxy_template_test'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "haproxy_template_test::default", "default recipe for the test."

attribute "hapxory_template_test/bar",
  :display_name => "haproxy foobar",
  :description => "foobar foo.",
  :required => "optional",
  :recipes => [ "haproxy_template_test::default" ]