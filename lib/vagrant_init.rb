# This file is automatically loaded by Vagrant to load any
# plugins. This file kicks off this plugin.

require 'vagrant-fog-box-storage'

Vagrant.config_keys.register(:fog_box_storage) { VagrantFogBoxStorage::Config }
