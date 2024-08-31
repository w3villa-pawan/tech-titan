class Chat < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  has_many :messages, dependent: :destroy

  def self.get_chat(sender_id, receiver_id)
    where(
      "(sender_id = :sender_id AND receiver_id = :receiver_id) OR
      (sender_id = :receiver_id AND receiver_id = :sender_id)",
      sender_id: sender_id, receiver_id: receiver_id
    ).first
  end
end