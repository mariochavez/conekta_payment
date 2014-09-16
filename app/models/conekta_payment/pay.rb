module ConektaPayment
  class Pay < ActiveRecord::Base
    BASE_CURRENY = 'MNX'.freeze
    PAID = 'paid'.freeze

    attr_accessor :conekta_token

    validates :cart_id, :email, :cash_type,
      :total, :cart, presence: true

    def charge=(value)
      self.paid = value['status'] == PAID if value['status']
      self.last_four = value['payment_method']['last4'] if value['payment_method']
      write_attribute :charge, value
    end

    def to_charge
      {
        curreny: BASE_CURRENY,
        amount: (total ? sprintf('%.2f', total).gsub(/\./, '') : 0).to_i,
        description: cart['description'],
        reference_id: "#{email}::#{cart_id}",
        card: conekta_token
      }
    end
  end
end
