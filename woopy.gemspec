# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "woopy/version"

Gem::Specification.new do |s|
  s.name        = "woopy"
  s.version     = Woopy::VERSION
  s.authors     = ["Big Bang Technology"]
  s.email       = ["developers@bigbangtechnology.com"]
  s.homepage    = "http://woople.com/"
  s.summary     = %q{Woople API Wrapper}
  s.description = %q{Wraps the Woople API as ActiveResources}

  s.rubyforge_project = "woopy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~> 2.8"
  s.add_development_dependency "json"
  s.add_development_dependency "gem-release"
  # s.add_runtime_dependency "rest-client"
  s.add_dependency 'activeresource',  '~> 3.1'
end
