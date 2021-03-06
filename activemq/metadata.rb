maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Installs activemq and sets it up as service"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{ubuntu debian redhat centos}.each do |os|
  supports os
end

%w{java}.each do |cb|
  depends cb
end

recipe "activemq::default", "Installs/configures activemq."

attribute "activemq/mirror",
  :display_name => "ActiveMQ mirror",
  :description => "download URL up to the activemq/apache-activemq directory.",
  :default => "http://apache.mirrors.tds.net",
  :recipes => [ "activemq::default" ]

attribute "activemq/version",
  :display_name => "ActiveMQ version",
  :description => "ActiveMQ version to install.",
  :default => "5.5.1",
  :recipes => [ "activemq::default" ]

attribute "activemq/home",
  :display_name => "ActiveMQ deploy directory",
  :description => "Directory to deploy to (/opt by default",
  :default => "/opt",
  :recipes => [ "activemq::default" ]
