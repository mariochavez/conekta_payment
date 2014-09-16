require 'test_helper'

module ConektaPayment
  describe Pay do
    let(:pay) { Pay.new }

    describe 'validations' do
      it 'must be valid' do
        pay.cart_id = 1
        pay.email = 'sample@mail.com'
        pay.cash_type = 'Banco'
        pay.total = 200.00
        pay.cart = { items: []  }

        pay.must_be :valid?
      end

      it 'must be invalid' do
        pay.wont_be :valid?
        pay.errors.count.must_equal 5
      end
    end

    describe 'charge hash' do
      it 'must conform basic pay charge for conekta' do
        charge_hash = {
          curreny: 'MNX',
          amount: 20000,
          description: 'Compra de eBook Aprendiendo Ruby on Rails 4.0',
          reference_id: 'sample@email.com::1',
          card: 'token'
        }

        pay.cart_id = 1
        pay.email = 'sample@email.com'
        pay.cash_type = 'Banco'
        pay.total = 200.00
        pay.conekta_token = 'token'
        pay.cart = {
          description: 'Compra de eBook Aprendiendo Ruby on Rails 4.0',
          items: []
        }

        pay.to_charge.must_equal charge_hash
      end

      it 'must set paid and last_four on success charge' do
        pay.charge = successful_payment

        pay.last_four.must_equal '4242'
        pay.must_be :paid?
      end
    end
  end
end
