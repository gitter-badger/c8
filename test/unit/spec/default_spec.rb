# Encoding: utf-8

require_relative 'spec_helper'

describe 'c8::default' do
  before { stub_resources }
  # for this run we setup as platform, version and some memory.total(via 'fauxhai' as automatic)
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.automatic['memory']['total'] = '1048576kb'
      node.automatic['public_info']['remote_ip'] = '127.0.0.1'
      node.automatic['drupal']['db_password'] = 'password'
      node.automatic['drupal']['db_source'] = 'http://dearing.link/db.sql'
    end.converge('c8::default')
  end

  it 'should install phpstack' do
    chef_run.should include_recipe 'phpstack::application_php'
  end

end
