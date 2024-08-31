class CreateMessage < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :senders
      t.references :receivers

      t.timestamps
    end
  end
end
