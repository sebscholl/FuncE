# frozen_string_literal: true

# rubocop:disable all
Gem::Specification.new do |spec|
  spec.name          = 'func_e'
  spec.version       = '0.0.1'
  spec.authors       = ['Sebastian Scholl']
  spec.email         = ['sebscholl@gmail.com']

  spec.summary       = 'FuncE provides an interface between Node.js functions and Ruby applications, enabling easy integration without the need for deploying functions with endpoints.'
  spec.description   = "FuncE is a lightweight Ruby gem that allows developers to call JavaScript functions from within Ruby applications. By providing a clean interface between Node.js functions and Ruby, FuncE offers a Function-as-a-Service (FaaS)-like experience without the overhead of managing and deploying endpoints. It supports asynchronous functions and the use of required packages, making it a versatile tool for modern web applications."

  spec.homepage      = 'https://github.com/sebscholl/func-e'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.5'

  spec.files         = Dir['lib/**/*.rb'] + Dir['exe/**/*'] + Dir['README.md']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'json', '~> 2.0'
  spec.add_runtime_dependency 'terrapin', '~> 0.6'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
# rubocop:enable all
