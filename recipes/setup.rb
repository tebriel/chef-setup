#
# Cookbook Name:: setup
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'nano' do
  action :remove
end

package 'tree'

cookbook_file '/etc/ssh/ssh_config'

directory '/home/chef/.ssh'
cookbook_file '/home/chef/.ssh/authorized_keys' do
  mode '0600'
  user 'chef'
  group 'chef'
end

file '/etc/motd' do
  content 'Property of ...\n'
end
