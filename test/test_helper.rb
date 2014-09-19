# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'minitest/autorun'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'webmock/minitest'
require 'capybara/poltergeist'
require 'pry'
require 'conekta'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

module Minitest::Expectations
  infect_an_assertion :assert_redirected_to, :must_redirect_to
  infect_an_assertion :assert_template, :must_render_template
  infect_an_assertion :assert_response, :must_respond_with
end

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

class Minitest::Unit::TestCase
  class << self
    alias_method :context, :describe
  end
end

include FeaturesHelper
include ConektaHelper

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
#Capybara.default_driver = :selenium

@server_thread = Thread.new do
  Rack::Handler::Thin.run Conekta::Server.new, :Port => 2121
end
sleep(1)

Conekta.api_base = 'http://127.0.0.1:2121'
WebMock.disable_net_connect!(allow_localhost: true)
