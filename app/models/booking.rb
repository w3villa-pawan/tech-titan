# app/models/booking.rb
class Booking < ApplicationRecord
  belongs_to :hotel
  belongs_to :user

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[booked checked_in checked_out cancelled] }

  #validate :check_in_before_check_out

  private

  def check_in_before_check_out
    if check_in.present? && check_out.present? && check_in >= check_out
      errors.add(:check_in, 'must be before check out')
    end
  end
end
