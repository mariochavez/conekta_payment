class CreateConektaPaymentPays < ActiveRecord::Migration
  def change
    execute 'CREATE EXTENSION hstore'

    create_table :conekta_payment_pays do |t|
      t.integer   :cart_id,   null: false
      t.string    :email,     null: false
      t.string    :last_four, null: false
      t.string    :cash_type, null: false
      t.decimal   :total,     precision: 5, scale: 2
      t.hstore    :cart,      null: false
      t.hstore    :charge

      t.timestamps
    end
  end
end
