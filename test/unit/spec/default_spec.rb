# Encoding: utf-8

require_relative 'spec_helper'

describe 'c8::default' do
  before { stub_resources }
  describe 'ubuntu' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'should install phpstack' do
      chef_run.should include_recipe 'phpstack::application_php'
    end
  end
end
