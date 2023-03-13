# frozen_string_literal: true

require_relative "lib/increase/version"

Gem::Specification.new do |spec|
  spec.name = "increase"
  spec.version = Increase::VERSION
  spec.authors = ["Streamlined"]
  spec.email = ["developers@streamlinedpayments.com"]

  spec.summary = "Ruby bindings for Increase API"
  spec.description = "Simple library for Increase.com"
  spec.homepage = "https://www.increase.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 1.0.0"
  spec.add_dependency "faraday_curl"
  spec.add_dependency "faraday_middleware"

  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "dotenv"
end
