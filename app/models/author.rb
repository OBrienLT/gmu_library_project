class Author < ActiveRecord::Base
	validates :name, :dob, presence: true
	has_many :books, dependent: :destroy
end