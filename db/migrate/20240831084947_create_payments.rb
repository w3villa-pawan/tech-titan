class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.string :payment_intent_id
      t.string :payment_method
      t.string :payment_status
      t.date :payment_date
      t.integer :amount
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
