# -*- encoding: utf-8 -*-
require File.expand_path("../lib/vagrant-fog-box-storage/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "vagrant-fog-box-storage"
  s.version     = VagrantFogBoxStorage::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nat Lownes"]
  s.email       = ["nat.lownes@gmail.com"]
  s.homepage    = "https://github.com/natlownes/vagrant-fog-box-storage"
  s.summary     = "The use case is if you have a vagrant box, stored on S3 (or another storage provider supported by fog) that you don't want to be downloadable publicly that you need to authenticate somehow to get at."
  s.description = ""

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "vagrant" , "~> 1.0.6"
  s.add_dependency "fog"     , "~> 1.0"

  s.add_development_dependency "protest" , "~> 0.4.0"
  s.add_development_dependency "mocha"   , "~> 0.9.8"
  s.add_development_dependency "bundler" , ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
