# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "torquebox-sidekiq-service"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin Menard"]
  s.date = "2013-03-14"
  s.description = "    The TorqueBox Sidekiq service replaces the traditional Sidekiq CLI client for starting a Sidekiq processor.  This\n    allows TorqueBox features only available in-container to be usable by all your Sidekiq workers.  It has the added\n    benefit of reducing memory overhead by running in a single JVM and allows for better optimization through JIT and\n    better debugging & profiling through TorqueBox's runtime inspection facilities.\n"
  s.email = "nirvdrum@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/torque_box/sidekiq_service.rb",
    "lib/torquebox-sidekiq-service.rb",
    "test/helper.rb",
    "test/sidekiq_service_test.rb"
  ]
  s.homepage = "http://github.com/mogotest/torquebox-sidekiq-service"
  s.licenses = ["ASLv2"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A TorqueBox service for running Sidekiq in the TorqueBox application server."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sidekiq>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<sidekiq>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<sidekiq>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

