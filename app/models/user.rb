class User < ActiveRecord::Base
	after_destroy :ensure_an_admin_remains

  validates :name, :user_id, presence: true, uniqueness: true
  has_secure_password

	has_many :reservations, dependent: :destroy
	has_many :books, :through => :reservations

  private
		def ensure_an_admin_remains
			if User.count.zero?
				raise "Can't delete last user"
			end
		end
end
