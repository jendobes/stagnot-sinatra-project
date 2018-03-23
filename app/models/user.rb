class User < ActiveRecord::Base
  has_many :wishlists
  has_many :todos, through: :wishlists
  has_many :completes
  has_many :todos, through: :completes
  has_secure_password


end
