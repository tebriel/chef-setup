#
# Cookbook Name:: setup
# Recipe:: setup
#
# Copyright 2015, Umbrella Corp
#
# All rights reserved - Do Not Redistribute
#

package 'nano' do
  action :remove
end

package 'tree'
package 'ctags'
package 'screen'

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

template '/etc/motd'

service 'sshd' do
  action [:start, :enable]
end
