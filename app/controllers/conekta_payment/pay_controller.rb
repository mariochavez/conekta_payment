require_dependency "conekta_payment/application_controller"

module ConektaPayment
  class PayController < ApplicationController

    def new
      @pay = Pay.new
    end

    def create
      @pay = Pay.new pay_params
      @pay.cart = shopping_cart
      @pay.cash_type = ConektaPayment::BANK_CASH_TYPE unless @pay.cash_type = ConektaPayment::OXXO_CASH_TYPE

      if @pay.valid?
        response, error = BankPaymentProcessor.create_charge(@pay.to_charge)
        view = :new

        if error.nil?
          @pay.charge = response

          error = PaymentError.new(Exception.new(@pay.charge['failure_message']), true) if !@pay.paid?

          @pay.error = error.try(:to_hash)
          @pay.save

          view = :create if @pay.paid?
        else
          view = :error unless error.recoverable
        end
      end

      log_message error, @pay if error
      render view
    end

    private
    def log_message(error, payment)

      if error.recoverable
        title = 'PaymentFailed'
        message = "Reference: #{payment.try(:charge).try('[]', 'id') || payment.cart_id} - #{payment.try(:charge).try('[]', 'failure_message') || error.message}"
      else
        title = 'PaymentError'
        message = "#{error.inner_class}: [#{error.code}]: #{error.message}"
      end

      Rails.logger.error "[#{title}]:: #{message}"
    end

    def pay_params
      params.require(:pay).permit(:cart_id, :total, :conekta_token, :email, :last_four)
    end
  end
end
