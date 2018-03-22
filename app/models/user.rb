class User < ActiveRecord::Base
  has_many :todos, through: :list
  has_secure_password


end
