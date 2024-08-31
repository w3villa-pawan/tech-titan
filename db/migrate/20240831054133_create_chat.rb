class CreateChat < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.references :senders
      t.references :receivers
      t.references :hotels

      t.timestamps
    end
  end
end
