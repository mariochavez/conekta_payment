$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "conekta_payment/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "conekta_payment"
  s.version     = ConektaPayment::VERSION
  s.authors     = ["Mario A Chavez"]
  s.email       = ["mario.chavez@gmail.com"]
  s.homepage    = "http://railsenepsanol.co"
  s.summary     = "Rails engine to process payments via Conekta."
  s.description = "A mountable Rails engine that handle all the steps to process payments via mexican gateway Conekta."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "coffee-rails"
  s.add_dependency "conekta"
  s.add_dependency "jquery-rails"
  s.add_dependency "pg"
  s.add_dependency "rails", "~> 4.1.5"
  s.add_dependency "sass-rails"

  s.add_development_dependency "better_errors"
  s.add_development_dependency "launchy"
  s.add_development_dependency "minitest-rails"
  s.add_development_dependency "minitest-rails-capybara"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "thin"
  s.add_development_dependency "webmock"
end
