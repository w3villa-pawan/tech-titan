# app/models/review.rb
class Review < ApplicationRecord
    belongs_to :user
    belongs_to :hotel
  
    validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :display, inclusion: { in: [true, false] }
  end
  