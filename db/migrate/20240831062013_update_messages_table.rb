class UpdateMessagesTable < ActiveRecord::Migration[7.2]
  def change
    rename_column :messages, :senders_id, :sender_id
    rename_column :messages, :receivers_id, :receiver_id
  end
end
