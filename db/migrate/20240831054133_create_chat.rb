class CreateChat < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.references :sender
      t.references :receiver
      t.references :hotel

      t.timestamps
    end
  end
end
