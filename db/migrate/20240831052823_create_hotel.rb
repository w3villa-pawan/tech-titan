class CreateHotel < ActiveRecord::Migration[7.2]
  def change
    create_table :hotels do |t|
      t.references :user
      t.string :name
      t.text :description
      t.references :hotel_type
      t.integer :total_rooms, default: 0
      t.integer :available_rooms, default: 0

      t.timestamps
    end
  end
end
