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
        post :create, pay: payment

        must_respond_with :success
        must_render_template :create
      end
    end

    it 'display apologize on critical error' do
      Conekta::Charge.stub :create, raise_exception do
        post :create, pay: payment

        must_respond_with :success
        must_render_template :error
      end
    end

    it 'display payment form if payment error out' do
      Conekta::Charge.stub :create, failed_payment do
        post :create, pay: payment

        must_respond_with :success
        must_render_template :new
      end
    end
  end
end
