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

  spec.add_development_dependency('bundler', '~> 1.16')
  spec.add_development_dependency('faker', '~> 1.9')
  spec.add_development_dependency('rake', '~> 10.0')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('rubocop')
  spec.add_development_dependency('simplecov')
  spec.add_development_dependency('simplecov-console')
end
