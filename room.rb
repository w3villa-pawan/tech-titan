# app/models/room.rb
class Room < ApplicationRecord
    belongs_to :hotel
  
    validates :no_of_people, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    validates :price, numericality: { greater_than_or_equal_to: 0 }
  end
  