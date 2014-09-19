$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "conekta_payment/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "conekta_payment"
  s.version     = ConektaPayment::VERSION
  s.authors     = ["Mario A Chavez"]
  s.email       = ["mario.chavez@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ConektaPayment."
  s.description = "TODO: Description of ConektaPayment."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
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
