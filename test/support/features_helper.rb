module FeaturesHelper
  def engine_routes
    ConektaPayment::Engine.routes.url_helpers
  end
end
