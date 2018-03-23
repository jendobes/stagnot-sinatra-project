class Todo < ActiveRecord::Base
  has_many :wishlists
  has_many :users, through: :wishists
  has_many :completes
  has_many :users, through: :completes
end
