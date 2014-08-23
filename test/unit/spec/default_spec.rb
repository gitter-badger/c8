# Encoding: utf-8

require_relative 'spec_helper'

describe 'c8::default' do
  before { stub_resources }
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.automatic['memory']['total'] = '1048576kb'
      node.automatic['public_info']['remote_ip'] = '127.0.0.1'
      node.automatic['drupal']['db_password'] = 'password'
      node.automatic['drupal']['db_source'] = 'http://example.tld/db.sql'
    end.converge('c8::default')
  end

  it 'should install phpstack' do
    chef_run.should include_recipe 'phpstack::application_php'
  end

  it 'should inclde rackops_rolebook::rack_user' do
    chef_run.should include_recipe 'rackops_rolebook::rack_user'
  end

  it 'should create drupal database' do
    expect(chef_run).to create_mysql_database('drupal')
  end

  it 'should grant drupaluser' do
    expect(chef_run).to grant_mysql_database_user('drupaluser')
  end

end
