# app/models/booking.rb
class Booking < ApplicationRecord
  belongs_to :hotel
  belongs_to :user

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[pending booked checked_in checked_out cancelled] }

  validate :check_in_before_check_out
  validate :check_out_after_today, on: :create
  validate :no_double_booking

  private

  def check_in_before_check_out
    if check_in.present? && check_out.present? && check_in >= check_out
      errors.add(:check_in, 'must be before check out')
    end
  end

  def check_out_after_today
    if check_out.present? && check_out <= Date.today
      errors.add(:check_out, 'must be after today')
    end
  end

  def no_double_booking
    return unless hotel_id.present? && check_in.present? && check_out.present?

    # Check for overlapping bookings for the same hotel
    overlapping_bookings = Booking.where(hotel_id: hotel_id)
                                  .where.not(id: id) # Exclude current booking if updating
                                  .where.not(status: 'cancelled')
                                  .where(
                                    '(check_in <= ? AND check_out > ?) OR (check_in < ? AND check_out >= ?) OR (check_in >= ? AND check_out <= ?)',
                                    check_out, check_in,
                                    check_out, check_in,
                                    check_in, check_out
                                  )

    if overlapping_bookings.exists?
      errors.add(:base, 'These dates overlap with an existing booking')
    end
  end
end
