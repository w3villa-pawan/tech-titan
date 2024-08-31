class Address < ApplicationRecord
    # Associations
    belongs_to :hotel
  
    # Validations
    validates :firstname, :lastname, :address1, :city, :zipcode, :phone, presence: true
    validates :zipcode, format: { with: /\A\d{5}(-\d{4})?\z/, message: "must be a valid ZIP code" }
    validates :latitude, :longitude, format: { with: /\A-?\d+(\.\d+)?\z/, message: "must be a valid number" }, allow_blank: true
  
    # Additional methods or scopes if needed
  end
  