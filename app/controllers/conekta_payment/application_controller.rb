module ConektaPayment
  class ApplicationController < ::ApplicationController

    def shopping_cart
      raise 'Implement #shopping_cart_hash in application controller' unless respond_to?(:shopping_cart_hash, true)

      shopping_cart_hash
    end

    helper_method :shopping_cart

  end
end
