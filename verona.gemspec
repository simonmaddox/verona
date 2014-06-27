# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "verona/version"

Gem::Specification.new do |s|
  s.name        = "verona"
  s.authors     = ["Simon Maddox"]
  s.email       = "simon@simonmaddox.com"
  s.license     = "MIT"
  s.homepage    = "http://simonmaddox.com"
  s.version     = Verona::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Google Play In-App Purchase Token Verification"
  s.description = ""

  s.add_dependency "json"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
