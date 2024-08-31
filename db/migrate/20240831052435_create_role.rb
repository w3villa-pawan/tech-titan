class CreateRole < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
