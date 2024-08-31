class AddChatIdToMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :chat_id, :bigint
  end
end
