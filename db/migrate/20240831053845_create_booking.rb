class CreateBooking < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.references :hotel
      t.references :user
      t.datetime :check_in
      t.datetime :check_out
      t.decimal :price
      t.string :status, default: 'booked'

      t.timestamps
    end
  end
end
