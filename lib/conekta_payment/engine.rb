require 'sass/rails'
require 'jquery-rails'

module ConektaPayment
  class Engine < ::Rails::Engine
    isolate_namespace ConektaPayment

    config.generators do |g|
      g.test_framework :minitest, spec: true, fixtures: true
      g.integration_tool :minitest
      g.helper false
      g.assets false
      g.view_specs false
    end
  end
end
