class Todo < ActiveRecord::Base
  has_many :users, through: :list

end
