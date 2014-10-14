class User < ActiveRecord::Base
  validates :name, :user_id, presence: true, uniqueness: true
  has_secure_password
end
