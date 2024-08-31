# app/models/property.rb
class Property < ApplicationRecord
    # Associations
    has_many :hotel_properties
    has_many :hotels, through: :hotel_properties
  
    # Validations
    validates :name, presence: true
    validates :unique_name, presence: true
  end
  