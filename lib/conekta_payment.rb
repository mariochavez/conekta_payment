require "conekta_payment/engine"

module ConektaPayment
  BANK_CASH_TYPE = 'BANCO'.freeze
  OXXO_CASH_TYPE = 'OXXO'.freeze

  mattr_accessor :public_key, :private_key
end
