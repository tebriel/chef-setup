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
package 'ctags'


cookbook_file '/etc/ssh/sshd_config' do
  notifies :restart, 'service[sshd]', :immediate
end

user 'chef'

directory '/home/chef/.ssh'
cookbook_file '/home/chef/.ssh/authorized_keys' do
  mode '0600'
  user 'chef'
  group 'chef'
end

file '/etc/motd' do
  content 'Property of ...\n'
end

service 'sshd' do
  action [:start, :enable]
end
