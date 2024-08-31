class CreateReview < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :hotel
      t.integer :rating, default: 0
      t.boolean :display, default: true

      t.timestamps
    end
  end
end
