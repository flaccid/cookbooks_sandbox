#
# Cookbook Name:: haproxy_template_test
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/usr/share/haproxy"

template "/usr/share/haproxy/504.http" do
  source "504.http.erb"
  variables({
    :content_type => node['haproxy_template_test']['bar']
  })
end