# frozen_string_literal: true

require "leash"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

if ENV["DD_ENV"] == "ci"
  Datadog.configure do |c|
    c.service = "leash"

    c.ci.enabled = true
    c.ci.instrument :rspec
  end
end
