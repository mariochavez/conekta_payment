require_dependency "conekta_payment/application_controller"

module ConektaPayment
  class PayController < ApplicationController

    def new
      @pay = Pay.new
    end

    def create
      pay = Pay.new pay_params
      pay.cart = shopping_cart
      pay.cash_type = ConektaPayment::BANK_CASH_TYPE #unless pay.cash_type = ConektaPayment::OXXO_CASH_TYPE

      if pay.valid?
        response, error = BankPaymentProcessor.create_charge(pay.to_charge)
        view = :new

        if error.nil?
          pay.charge = response

          error = PaymentError.new(Exception.new(pay.charge['failure_message']), true) if !pay.paid?

          view = :create if pay.paid?
        else
          view = :error unless error.recoverable
        end

        pay.error = error.try(:to_hash)
        pay.save
      end

      if error
        @pay = build_pay_from(pay)
        log_message error, pay
      else
        @pay = pay
      end

      render view
    end

    private
    def build_pay_from(current_pay)
      Pay.new.tap do |p|
        p.email = current_pay.email
        p.error = current_pay.error
      end
    end

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
