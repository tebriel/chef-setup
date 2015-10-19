#
# Cookbook Name:: workstation
# Spec:: setup
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'workstation::setup' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'Removes Nano if it exists' do
      expect(chef_run).to remove_package('nano')
    end

    it 'Installs tree' do
      expect(chef_run).to install_package('tree')
    end

    it 'Installs ctags' do
      expect(chef_run).to install_package('ctags')
    end

    it 'Adds the chef user' do
      expect(chef_run).to create_user('chef')
    end

    it 'Updates the sshd config file' do
      expect(chef_run).to create_cookbook_file('/etc/ssh/sshd_config')
    end

    it 'Restarts the ssh service' do
      expect(chef_run).to restart_service('sshd')
    end

    it 'Creates the chef ssh folder' do
      expect(chef_run).to create_directory('/home/chef/.ssh')
    end

    it 'Adds the auth keys' do
      expect(chef_run).to create_cookbook_file('/home/chef/.ssh/authorized_keys')
        .with(user: 'chef', group: 'chef', mode: '0600')
    end

    it 'Creates the motd' do
      expect(chef_run).to create_file('/etc/motd')
        .with(content: 'Property of ...\n')
    end
  end
end
