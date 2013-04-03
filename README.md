# vagrant-fog-box-storage

### Note - this is not yet compatible with Vagrant 1.1.

Use the [fog](http://fog.io/) gem to get the authenticated url of a box to download from your favorite
cloud storage jawn.

The use case is if you have a vagrant box, stored on S3 (or another storage
provider supported by fog) that you don't want to be downloadable publicly that
you need to authenticate somehow to get at.

Note that this doesn't actually add an additional vagrant downloader class, but instead
grabs the authenticated url and uses ```Vagrant::Downloaders::HTTP``` to fetch
the box.

Example:

```ruby
require 'vagrant-fog-box-storage'

Vagrant::Config.run do |config|
  config.vm.define :app do |app_config|
    app_config.fog_box_storage.provider          = 'AWS'
    app_config.fog_box_storage.access_key_id     = "AAAAAAAAAAAAAAA"
    app_config.fog_box_storage.secret_access_key = "XXXXXXXXXXXXXXXXXXXXXXXXX"
    app_config.fog_box_storage.bucket_name       = "awesome-secret-bukkit"
    app_config.fog_box_storage.box_file_name     = "secret-linux.box"

    app_config.vm.box_url = app_config.fog_box_storage.box_url

    app_config.vm.box = "secret-linux"
  end
end

```

## TODO

Not sure if there's a way to reach in and set ```vm.box_url``` from within the
plugin instead of having to call the ```#box_url``` method from the plugin from
the Vagrantfile.

## What else?

I've only used this with S3.
