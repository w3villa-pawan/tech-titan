# app/models/role.rb
class Role < ApplicationRecord
    # Associations
    has_many :user_roles
    has_many :users, through: :user_roles
  
    # Validations
    validates :name, presence: true
  end
  