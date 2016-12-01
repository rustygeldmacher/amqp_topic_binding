# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amqp_topic_binding/version'

Gem::Specification.new do |spec|
  spec.name          = "amqp_topic_binding"
  spec.version       = AmqpTopicBinding::VERSION
  spec.authors       = ["Rusty Geldmacher"]
  spec.email         = ["russell.geldmacher@gmail.com"]

  spec.summary       = %q{A matcher for the AMQP topic binding algorithm}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/rustygeldmacher/amqp_topic_binding"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
