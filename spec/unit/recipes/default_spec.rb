#
# Cookbook Name:: vra-iaas-cookbook
# Spec:: default
#
# Copyright (c) 2016 The Authors, all_rights

require 'spec_helper'

describe 'vra-iaas-cookbook::default' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::ServerRunner.new(UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  describe 'windows' do
    let(:runner) { ChefSpec::ServerRunner.new(WINDOWS_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
