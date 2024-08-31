class Room < ApplicationRecord
    # Associations
    belongs_to :hotel
  
    # Validations
    validates :no_of_people, numericality: { only_integer: true, greater_than: 0 }
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validates :category, presence: true
  
    # Default scope or additional methods if needed
  end
  