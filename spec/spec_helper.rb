require 'rack/test'
require 'rspec'
require 'factory_girl'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

FactoryGirl.define do
  Digest::MD5.new

  factory :message do
    body            'lorem ipsum dolor'
    destroy_option  'visits'
    countdown       5
    password        Digest::MD5.new << '12341'

    trait :admin do
      admin true
    end
  end
end
