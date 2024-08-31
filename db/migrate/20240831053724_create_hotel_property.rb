class CreateHotelProperty < ActiveRecord::Migration[7.2]
  def change
    create_table :hotel_properties do |t|
      t.references :hotels
      t.references :properties
      t.boolean :display, default: true

      t.timestamps
    end
  end
end
