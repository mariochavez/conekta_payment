module ConektaHelper
  def successful_payment
    { "id"=>"5417965c19ce88705f000b34", "livemode"=>false, "created_at"=>1410831964, "status"=>"paid", "currency"=>"MXN", "description"=>"Some desc", "reference_id"=>nil, "failure_code"=>nil, "failure_message"=>nil, "monthly_installments"=>nil, "object"=>"charge", "amount"=>2000, "paid_at"=>1410831965, "fee"=>371, "customer_id"=>"", "refunds"=>[], "payment_method"=>{ "name"=>"Jorge Lopez", "exp_month"=>"12", "exp_year"=>"19", "auth_code"=>"105679", "object"=>"card_payment", "last4"=>"4242", "brand"=>"visa" }, "details"=>{ "name"=>nil, "phone"=>nil, "email"=>nil, "line_items"=>[] } }
  end
end
