class CreateProperty < ActiveRecord::Migration[7.2]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.boolean :active
      t.string :unique_name

      t.timestamps
    end
  end
end
