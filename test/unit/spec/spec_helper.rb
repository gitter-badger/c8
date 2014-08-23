# Encoding: utf-8
require 'rspec/expectations'
require 'chef/sugar'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '12.04',
  log_level: ::LOG_LEVEL
}
::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}

def stub_resources
  stub_command('which sudo').and_return('/usr/bin/sudo')
  stub_command('/usr/sbin/apache2 -t').and_return('junk')
end

at_exit { ChefSpec::Coverage.report! }
