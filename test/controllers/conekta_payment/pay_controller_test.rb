require 'test_helper'

module ConektaPayment
  describe PayController do
    before do
      @routes = ConektaPayment::Engine.routes
    end

    it 'displays payment form' do
      get :new

      must_respond_with :success
      must_render_template :new
    end

    it 'process payment sucessful' do

      Conekta::Charge.stub :create, successful_payment do
        post :create, pay: {
          cart_id: 1,
          total: 200.00,
          conekta_token: 'token',
          email: 'sample@email.com',
        }

        must_respond_with :success
        must_render_template :create
      end
    end
  end
end
