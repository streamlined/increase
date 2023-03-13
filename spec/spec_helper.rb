# frozen_string_literal: true

require "increase"
require "pry"
require "webmock/rspec"
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<API_SECRET>') { ENV['TOKEN'] }
  config.filter_sensitive_data('<API_KEY>') { ENV['USERNAME'] }
  config.filter_sensitive_data('<TOKEN>') { |interaction|
    auths = interaction.request.headers['Authorization'].first
    if match = auths.match(/^Basic\s+([^,\s]+)/)
      match.captures.first
    end
  }
end

Dir["#{__dir__}/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
