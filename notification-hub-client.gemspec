# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'notification_hub/version'

Gem::Specification.new do |spec|
  spec.name          = "notification-hub-client"
  spec.version       = NotificationHub::VERSION
  spec.authors       = ['Devs']
  spec.email         = ["devs@truckpad.com.br"]

  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = "http://github.com/truckpad/notification-hub-client"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://gems.truckpad.io"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1.5'

  spec.add_dependency('activesupport', '>= 4.2')
  spec.add_dependency('aws-sdk', '~> 1.66')

  spec.add_development_dependency('bundler', '~> 1.13')
  spec.add_development_dependency('rake', '~> 10.0')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('factory_girl', '~> 4.8')
end
