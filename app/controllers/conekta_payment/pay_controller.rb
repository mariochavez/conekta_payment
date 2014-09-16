require_dependency "conekta_payment/application_controller"
require_dependency "conekta"

module ConektaPayment
  class PayController < ApplicationController
    BANK_CASH_TYPE = 'BANCO'.freeze
    OXXO_CASH_TYPE = 'OXXO'.freeze

    before_action :set_conekta, only: :create

    def new
      @pay = Pay.new
    end

    def create
      @pay = Pay.new pay_params
      @pay.cart = shopping_cart
      @pay.cash_type = BANK_CASH_TYPE unless @pay.cash_type = OXXO_CASH_TYPE

      if @pay.valid?
        begin
          @pay.charge = Conekta::Charge.create @pay.to_charge
          @pay.save!

          return render(:create) if @pay.paid?
        rescue Exception => @ex
          Rails.logger.info "[PaymentError]:: #{@ex.message}\nDetails:: #{@ex.to_s}"
          return render :error
        end
      end

      Rails.logger.info "[PaymentFailed]:: #{@pay.valid? ? @pay.charge['id'] : @pay.cart_id}"
      render :new
    end

    private
    def pay_params
      params.require(:pay).permit(:cart_id, :total, :conekta_token, :email)
    end

    def set_conekta
      if Conekta.api_key.nil?
        Conekta.locale = :es
        Conekta.api_key = ConektaPayment.private_key
      end
    end
  end
end
