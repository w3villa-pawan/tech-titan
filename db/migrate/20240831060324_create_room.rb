class CreateRoom < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.references :hotels
      t.integer :no_of_people, default: 1
      t.decimal :price, default: 0.0
      t.boolean :active, default: true
      t.string :category

      t.timestamps
    end
  end
end
