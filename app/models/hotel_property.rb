# app/models/hotel_property.rb
class HotelProperty < ApplicationRecord
    # Associations
    belongs_to :hotel
    belongs_to :property
  
    # Validations
    validates :display, inclusion: { in: [true, false] }
  end
  