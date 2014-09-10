class CreateConektaPaymentPays < ActiveRecord::Migration
  def change
    create_table :conekta_payment_pays do |t|
      t.integer :cart_id, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
