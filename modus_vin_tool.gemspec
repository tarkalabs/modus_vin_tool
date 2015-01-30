# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'modus_vin_tool/version'

Gem::Specification.new do |spec|
  spec.name          = "modus_vin_tool"
  spec.version       = ModusVinTool::VERSION
  spec.authors       = ["Robert Gallegos"]
  spec.email         = ["robertg@modusgo.com"]
  spec.summary       = "Modus Vin Tool API Compatibility Check"
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.add_dependency "nokogiri"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_development_dependency "psych", "~> 2.0.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
