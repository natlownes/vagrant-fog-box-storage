require 'vagrant/config'


module VagrantFogBoxStorage

  class CloudStorageBoxNotFound < Exception ; end
  class CloudStorageBucketNotFound < Exception ; end

  class Config < Vagrant::Config::Base
    def self.key_names
      [
        :provider,
        :access_key_id,
        :secret_access_key,
        :bucket_name,
        :box_file_name
      ]
    end

    self.key_names.each do |name|
      attr_accessor name
    end

    def is_used?
      self.class.key_names.any? do |name|
        !self.send(name).nil?
      end
    end

    def cloud_storage
      if is_used?
        provider_name = self.provider.to_s.downcase

        @cloud_storage ||= Fog::Storage.new({
          :provider => self.provider,
          :"#{provider_name}_access_key_id" => self.access_key_id,
          :"#{provider_name}_secret_access_key" => self.secret_access_key
        })
      end
    end

    def cloud_directories
      cloud_storage.directories
    end

    def box_directory
      directory = cloud_directories.get(self.bucket_name)

      raise CloudStorageBucketNotFound.new("#{self.bucket_name} does not exist") if !directory

      directory
    end

    def directory_files
      directory = box_directory()

      directory.files
    end

    def expiry_time
      Time.now + 3600
    end

    def box_url
      files = directory_files()

      url = files.get_https_url(self.box_file_name, expiry_time)

      url
    end

    def validate(env, errors)
      if is_used?
        errors.add('missing provider')          if !self.provider
        errors.add('missing access_key_id')     if !self.access_key_id
        errors.add('missing secret_access_key') if !self.secret_access_key
        errors.add('missing bucket_name')       if !self.bucket_name
        errors.add('missing box_file_name')     if !self.box_file_name
      end
    end
  end
end
