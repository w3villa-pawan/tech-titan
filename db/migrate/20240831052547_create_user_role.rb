class CreateUserRole < ActiveRecord::Migration[7.2]
  def change
    create_table :user_roles do |t|
      t.references :user
      t.references :role

      t.timestamps
    end
  end
end
