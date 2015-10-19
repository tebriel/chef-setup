#
# Cookbook Name:: setup
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# execute 'yum-config-manager --add-repo http://fishshell.com/files/linux/RedHat_RHEL-6/fish.release:2.repo'

package 'nano' do
  action :remove
end

package 'tree'
package 'ctags'
# package 'fish'

cookbook_file '/etc/ssh/sshd_config'

service 'sshd' do
  action :restart
end

directory '/home/chef/.ssh'
cookbook_file '/home/chef/.ssh/authorized_keys' do
  mode '0600'
  user 'chef'
  group 'chef'
end

file '/etc/motd' do
  content 'Property of ...\n'
end
