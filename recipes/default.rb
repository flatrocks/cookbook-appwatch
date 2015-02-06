#
# Cookbook Name:: appwatch
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'logwatch'

cookbook_file '/etc/logwatch/scripts/services/appwatch' do
  owner 'root'
  group 'root'
  mode 0755
end

cookbook_file '/etc/logwatch/conf/services/appwatch.conf' do
  owner 'root'
  group 'root'
  mode 0755
end

