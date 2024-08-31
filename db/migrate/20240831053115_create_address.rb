class CreateAddress < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string     :firstname
      t.string     :lastname
      t.string     :address1
      t.string     :address2
      t.string     :city
      t.string     :zipcode
      t.string     :phone
      t.string     :state_name
      t.string     :alternative_phone
      t.string     :company
      t.string     :longitude
      t.string     :latitude
      t.string :country_name
      t.references :hotels

      t.timestamps
    end
  end
end
