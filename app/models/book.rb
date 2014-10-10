class Book < ActiveRecord::Base

	validates :isbn, :title, :abstract, :pages, :genre, :published_on,
		:total_in_library, :author, presence: true
	validates :abstract, length: { minimum: 15 }
	validates :pages, :total_in_library, numericality: { only_integer: true, 
		greater_than_or_equal_to: 0 }

	belongs_to :author

end
