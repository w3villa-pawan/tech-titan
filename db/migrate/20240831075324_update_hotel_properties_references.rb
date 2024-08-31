class UpdateHotelPropertiesReferences < ActiveRecord::Migration[7.2]
  def change
    remove_reference :hotel_properties, :hotels, index: true
    remove_reference :hotel_properties, :properties, index: true

    # Add new references
    add_reference :hotel_properties, :hotel, foreign_key: true
    add_reference :hotel_properties, :property, foreign_key: true
  end
end
