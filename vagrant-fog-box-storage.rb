require 'vagrant'
require 'vagrant/config'
require 'vagrant-fog-box-storage/config'
require 'vagrant-fog-box-storage/middleware'

# Create a new middleware stack "rake" which is executed for
# rake commands. See the VagrantRake::Middleware docs for more
# information.
vagrant_fog_downloader = Vagrant::Action::Builder.new do
  use VagrantFogBoxStorage::Middleware
end

#Vagrant::Action.register(:rake, rake)
