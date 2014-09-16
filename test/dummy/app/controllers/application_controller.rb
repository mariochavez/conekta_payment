class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def shopping_cart_hash
    {
      cart_id: 1,
      subtotal: 200.00,
      description: 'Compra de eBooks Aprendiendo Ruby on Rails 4.0',
      items: [
        {
          product_id: 1,
          name: 'eBook Aprendiendo Ruby on Rails 4.0',
          price: 200.00,
          quantity: 1
        }
      ]
    }
  end
end
