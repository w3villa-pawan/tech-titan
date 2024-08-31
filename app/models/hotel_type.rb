# app/models/hotel_type.rb
class HotelType < ApplicationRecord
  has_many :hotels
  validates :name, presence: true
end
