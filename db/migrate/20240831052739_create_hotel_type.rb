class CreateHotelType < ActiveRecord::Migration[7.2]
  def change
    create_table :hotel_types do |t|
      t.string :name, default: 'hotel'
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
