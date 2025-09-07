# app/models/booking.rb
class Booking < ApplicationRecord
  belongs_to :hotel
  belongs_to :user

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[pending booked checked_in checked_out cancelled] }

  validate :check_in_before_check_out

  private

  def check_in_before_check_out
    return unless check_in.present? && check_out.present?
    
    if check_in >= check_out
      errors.add(:check_out, 'must be after check-in date')
    end
    
    # Additional validation: check-in cannot be in the past
    if check_in < Date.current
      errors.add(:check_in, 'cannot be in the past')
    end
  end
end
