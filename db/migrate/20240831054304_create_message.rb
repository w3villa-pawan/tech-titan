class CreateMessage < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :sender
      t.references :receiver

      t.timestamps
    end
  end
end
