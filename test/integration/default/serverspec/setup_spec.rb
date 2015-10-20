require 'spec_helper'

describe 'workstation::setup' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe package('nano') do
    it { should_not be_installed }
  end

  describe package('tree') do
    it { should be_installed }
  end

  describe package('ctags') do
    it { should be_installed }
  end

  describe package('screen') do
    it { should be_installed }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should exist }
    its(:content) { should match(/^PrintMotd yes/) }
  end

  describe user('chef') do
    it { should exist }
  end

  describe file('/home/chef/.ssh') do
    it { should be_directory }
  end

  describe file('/home/chef/.ssh/authorized_keys') do
    it { should exist }
    it { should be_mode 600 }
    it { should be_owned_by 'chef' }
    it { should be_grouped_into 'chef' }
  end

  describe file('/etc/motd') do
    ip_str = host_inventory['local-ipv4']
    hostname = host_inventory['hostname']
    memory = host_inventory['memory']['total']
    its(:content) { should match(/Property of .../) }
    its(:content) { should match(/#{ip_str}/) }
    its(:content) { should match(/#{hostname}/) }
    its(:content) { should match(/MemTotal: #{memory}/) }
  end
end
