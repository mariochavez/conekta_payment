module ConektaPayment
  class Pay < ActiveRecord::Base
    attr_accessor :conekta_token, :last_four
  end
end
