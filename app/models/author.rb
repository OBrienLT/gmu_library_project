class Author < ActiveRecord::Base
	validates :name, :dob, :nationality, :biography, :image_url, presence: true
	validates :biography, length: { minimum: 15, too_short: "the author's biography is too short." }
	has_many :books, dependent: :destroy
end