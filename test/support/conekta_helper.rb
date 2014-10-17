module ConektaHelper
  def payment
    {
      cart_id: 1,
      total: 200.00,
      conekta_token: 'token',
      email: 'sample@email.com',
    }
  end

  def successful_payment
    payment_hash
  end

  def failed_payment
    hash = payment_hash.clone
    hash['status'] = 'pending_payment'
    hash['failure_message'] = 'Su tarjeta fue declinada'
    hash
  end

  def error_payment
    {
      message: 'Tarjeta declinada',
      message_to_purchaser: 'Su tarjeta fue declinada',
      type: 'card_error',
      code: 'card_declined',
      param: '11111'
    }
  end

  def raise_exception
    ->(args) { raise Conekta::NoConnectionError.new('Critical error',
                                           'Critical error', 1,
                                           'no_connection', {}) }
  end

  private
  def payment_hash
    { "id"=>"5417965c19ce88705f000b34", "livemode"=>false, "created_at"=>1410831964, "status"=>"paid", "currency"=>"MXN", "description"=>"Some desc", "reference_id"=>nil, "failure_code"=>nil, "failure_message"=>nil, "monthly_installments"=>nil, "object"=>"charge", "amount"=>2000, "paid_at"=>1410831965, "fee"=>371, "customer_id"=>"", "refunds"=>[], "payment_method"=>{ "name"=>"Jorge Lopez", "exp_month"=>"12", "exp_year"=>"19", "auth_code"=>"105679", "object"=>"card_payment", "last4"=>"4242", "brand"=>"visa" }, "details"=>{ "name"=>nil, "phone"=>nil, "email"=>nil, "line_items"=>[] } }
  end
end
