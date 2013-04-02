require "test_helper"

Protest.describe("Configuration class") do
  setup do
    Fog.mock!

    @klass    = VagrantFogBoxStorage::Config
    @instance = @klass.new
    @errors   = {}
    @env      = mock('Vagrant::Environment')
  end

  should "be valid by default" do
    @instance.validate(@env, @errors)
    assert @errors.errors.empty?
  end

  should "be invalid if any one key is set and another is not" do
    @instance.provider = :aws
    @instance.validate(@env, @errors)

    assert !@errors.errors.empty?
  end

  should "be is_used? if all keys are set" do
    @instance.provider          = :aws
    @instance.access_key_id     = "1Z"
    @instance.secret_access_key = "1Z"
    @instance.bucket_name       = "bukkit"
    @instance.box_file_name     = "awesome.box"
  end

  context 'with all keys set' do
    setup do
      @instance.provider          = :aws
      @instance.access_key_id     = "1Z"
      @instance.secret_access_key = "1Z"
      @instance.bucket_name       = "bukkit"
      @instance.box_file_name     = "awesome.box"
    end

    context "#box_directory" do
      should "get the directory using bucket_name" do
        @instance.stubs(:cloud_directories).returns(dirs = [])
        dirs.expects(:get).with('bukkit').returns(mock('FogDirectory'))

        @instance.box_directory()
      end
    end

    context "#box_url" do
      context "when box is found" do
        setup do
          @instance.stubs(:directory_files).returns(@files = mock('Files'))
          @instance.stubs(:expiry_time).returns(@expires = Time.now)
        end

        should "return url for box" do
          @files.expects(:get_https_url).with(@instance.box_file_name, @expires).
            returns("http://example.com/files.gz")


          assert_equal "http://example.com/files.gz", @instance.box_url
        end
      end
    end
  end

end
