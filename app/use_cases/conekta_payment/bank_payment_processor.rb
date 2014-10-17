require_dependency "conekta"

module ConektaPayment
  class BankPaymentProcessor
    class << self
      def create_charge(charge)
        set_conekta
        error = nil

        begin
          response = Conekta::Charge.create(charge)
          payment = JSON.parse response.inspect.gsub('=>', ':').gsub('nil', 'null')
        rescue Conekta::ParameterValidationError, Conekta::ProcessingError => ex
          error = ConektaPayment::PaymentError.new ex, true
        rescue Conekta::AuthenticationError, Exception => ex
          error = ConektaPayment::PaymentError.new ex, false
        end

        [payment || {}, error]
      end

      def set_conekta
        if Conekta.api_key.nil?
          Conekta.locale = 'es'
          Conekta.api_key = ConektaPayment.private_key
        end
      end
    end
  end
end
