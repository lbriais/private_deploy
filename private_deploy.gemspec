# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'private_deploy/version'

Gem::Specification.new do |spec|
  spec.name          = 'private_deploy'
  spec.version       = PrivateDeploy::VERSION
  spec.authors       = ['Laurent B.']
  spec.email         = ['lbnetid+gh@gmail.com']
  spec.summary       = %q{Deploy your Gems to your own private repository.}
  spec.description   = %q{Gives possibility to declare a Gem private and therefore deploy it to a private repository.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'

  spec.add_runtime_dependency 'stacked_config'

  spec.add_dependency 'geminabox'

end
