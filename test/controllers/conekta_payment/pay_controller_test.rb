require "test_helper"

module ConektaPayment
  describe PayController do
    before do
      @routes = ConektaPayment::Engine.routes
    end

    it "should get new" do
      get :new
      must_respond_with :success
    end

    it "should get create" do
      get :create
      must_respond_with :success
    end

  end
end
