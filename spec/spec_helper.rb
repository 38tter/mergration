# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
ENV["DB"] ||= "sqlite"

require 'mergration'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Bundler.setup

require "active_record/railtie"
require "mergration"
require "rspec/rails"

require File.expand_path("test_app/config/environment", __dir__)

require_relative 'support/mergration_spec_migrator'
::MergrationSpecMigrator.new.migrate
