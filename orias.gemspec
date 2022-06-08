# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'orias/version'

Gem::Specification.new do |spec|
  spec.name          = 'orias'
  spec.version       = Orias::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['01max']
  spec.email         = ['m.louguet@gmail.com']

  spec.summary       = 'Wrapper for the Orias API (https://www.orias.fr/)'
  spec.description   = 'Easily access any data available from the Orias API.'
  spec.homepage      = 'https://github.com/01max/orias'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6.8'

  spec.add_runtime_dependency('libxml-to-hash', '~> 0.2')

  spec.add_development_dependency('bundler', '~> 2.3')
  spec.add_development_dependency('factory_bot_rails', '~> 6.2')
  spec.add_development_dependency('faker', '~> 2.20')
  spec.add_development_dependency('rake', '~> 13.0')
  spec.add_development_dependency('rspec', '~> 3.11')
  spec.add_development_dependency('rubocop', '~> 1.29')
  spec.add_development_dependency('simplecov', '~> 0.21')
  spec.add_development_dependency('simplecov-console', '~> 0.9')
  spec.add_development_dependency('webmock', '~> 3.14')
end
