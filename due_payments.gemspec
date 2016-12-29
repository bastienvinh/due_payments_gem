# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'due_payments/version'

Gem::Specification.new do |spec|
  spec.name          = "due_payments"
  spec.version       = DuePayments::VERSION
  spec.authors       = ["Bastien VINH"]
  spec.email         = ["bvinh.pro@gmail.com"]

  spec.summary       = %q{lala}
  spec.description   = %q{This is a gem to manage due-payments}
  spec.homepage      = "https://github.com/bastienvinh/due_payments_gem"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.3.0'

  # TODO : Improve this line
  spec.files = Dir['lib/due_payments/*.rb'] + Dir['bin/*'] + Dir['db/migrate/*'] + Dir['lib/due_payments/utils/*.rb'] + Dir['lib/due_payments/core/*.rb'] + Dir['lib/due_payments/dpm/*.rb'] + Dir['lib/due_payments/common/*.rb']
  spec.files << 'CODE_OF_CONDUCT.md'

  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables << 'duepgem'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  # Custom dependency
  spec.add_development_dependency "activerecord", "~> 5.0"
  spec.add_development_dependency "cmdparse", "~> 3.0"
  # spec.add_development_dependency "contracts"
  
end
