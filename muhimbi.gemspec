# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'muhimbi/version'

Gem::Specification.new do |spec|
  spec.name          = "muhimbi"
  spec.version       = Muhimbi::VERSION
  spec.authors       = ["miguel michelson"]
  spec.email         = ["miguelmichelson@gmail.com"]
  spec.description   = %q{Muhimbi Ruby Client}
  spec.summary       = %q{Muhimbi client}
  spec.homepage      = "http://github.com/michelson/muhimbi"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "debugger"

  spec.add_dependency "activesupport"
  spec.add_dependency "savon"
end
