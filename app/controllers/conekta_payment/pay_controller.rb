require_dependency "conekta_payment/application_controller"

module ConektaPayment
  class PayController < ApplicationController
    def new
      @pay = Pay.new
    end

    def create
    end
  end
end
