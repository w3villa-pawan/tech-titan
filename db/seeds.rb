# db/seeds.rb

# Create Users
user1 = User.create!(
  email: 'john.doe@example.com',
  password: 'password123',
  fullname: 'John Doe',
  avatar_url: 'https://example.com/avatar1.jpg',
  provider: 'email'
)

user2 = User.create!(
  email: 'jane.smith@example.com',
  password: 'password123',
  fullname: 'Jane Smith',
  avatar_url: 'https://example.com/avatar2.jpg',
  provider: 'email'
)

# Create Hotel Types
hotel_type1 = HotelType.create!(name: 'Luxury', active: true)
hotel_type2 = HotelType.create!(name: 'Budget', active: true)

# Create Hotels
hotel1 = Hotel.create!(
  name: 'Grand Palace Hotel',
  description: 'A luxurious hotel with world-class amenities.',
  user_id: user1.id,
  hotel_type: hotel_type1,
  total_rooms: 100,
  available_rooms: 50
)

hotel2 = Hotel.create!(
  name: 'Budget Inn',
  description: 'Affordable accommodation with essential amenities.',
  user_id: user2.id,
  hotel_type: hotel_type2,
  total_rooms: 50,
  available_rooms: 30
)

# Create Properties
property1 = Property.create!(name: 'Free Wi-Fi', description: 'Complimentary Wi-Fi throughout the hotel.', active: true, unique_name: 'free_wifi')
property2 = Property.create!(name: 'Gym', description: 'Fully equipped fitness center.', active: true, unique_name: 'gym')

# Create Hotel Properties
HotelProperty.create!(hotel_id: hotel1.id, property_id: property1.id, display: true)
HotelProperty.create!(hotel_id: hotel2.id, property_id: property2.id, display: true)

# Create Rooms
Room.create!(hotel_id: hotel1.id, no_of_people: 2, price: 200.00, active: true, category: 'Deluxe')
Room.create!(hotel_id: hotel2.id, no_of_people: 2, price: 80.00, active: true, category: 'Standard')

# Create Bookings
Booking.create!(
  hotel: hotel1,
  user: user1,
  check_in: DateTime.now + 1.day,
  check_out: DateTime.now + 3.days,
  price: 400.00,
  status: 'booked'
)

Booking.create!(
  hotel: hotel2,
  user: user2,
  check_in: DateTime.now + 2.days,
  check_out: DateTime.now + 5.days,
  price: 240.00,
  status: 'booked'
)

#

# Create Reviews
Review.create!(
  user_id: user1.id,
  hotel_id: hotel1,
  rating: 5,
  display: true
)

Review.create!(
  user_id: user2.id,
  hotel_id: hotel2,
  rating: 4,
  display: true
)


# Create Chats
# Chat.create!(
#   sender: user1,
#   receiver: user2,
#   hotel: hotel1,
#   created_at: DateTime.now
# )

puts "Seed data created successfully!"
