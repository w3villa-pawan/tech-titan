# app/models/hotel.rb
class Hotel < ApplicationRecord
  belongs_to :user
  belongs_to :hotel_type
  has_many :hotel_properties
  has_many :properties, through: :hotel_properties
  has_many :rooms
  has_many :bookings
  has_many :chats
  has_many :reviews
  has_one :address
  validates :name, presence: true
  validates :description, presence: true
  validates :hotel_type, presence: true
  validates :total_rooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :available_rooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_validation :generate_description_from_ai, on: :create

  private

  def generate_description_from_ai
    return if description.present? # Skip if description is already provided

    client = Groq::Client.new
    prompt = "Generate a hotel description for a hotel named '#{name}', located in #{location}, with #{total_rooms} rooms."
    response = client.chat(prompt)

    if response && response['content'].present?
      self.description = response['content']
    end
  end

end
