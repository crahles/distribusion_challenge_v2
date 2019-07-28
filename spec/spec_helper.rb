# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

Dir[File.join(__dir__, '..', 'lib', '**', '*.rb')].each { |file| require file }

RSpec.configure do |config|
  require 'webmock/rspec'
  WebMock.disable_net_connect!(allow_localhost: true)

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
