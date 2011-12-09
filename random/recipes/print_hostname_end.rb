# Cookbook Name:: random
# Recipe:: print_hostname_end
#
# Copyright 2011, Chris Fordham
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Show the new host/node information
ruby_block "print_hostname_end" do
  block do
    # show new host values from system
    Chef::Log.info("== last recipe using ruby_block ==")
    Chef::Log.info("hostname : #{`hostname`.strip == '' ? '<none>' : `hostname`.strip}")
    Chef::Log.info("uname -n : #{`uname -n`.strip == '' ? '<none>' : `uname -n`.strip}")
    Chef::Log.info("hostname -a : #{`hostname -a`.strip == '' ? '<none>' : `hostname -a`.strip}")
    Chef::Log.info("hostname -s : #{`hostname -s`.strip == '' ? '<none>' : `hostname -s`.strip}")
    Chef::Log.info("domainname : #{`domainname`.strip == '' ? '<none>' : `domainname`.strip}")
    Chef::Log.info("hostname -f : #{`hostname -f`.strip == '' ? '<none>' : `hostname -f`.strip}")
    Chef::Log.info("hostname -i : #{`hostname -i`.strip == '' ? '<none>' : `hostname -i`.strip}")
  end
end