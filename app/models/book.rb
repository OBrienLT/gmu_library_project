class Book < ActiveRecord::Base
	
	GENRES = [ "Biography", "Classic", "Crime/Detective", "Fantasy", "Historical Fiction", "Humor", "Mystery",
				"Science Fiction", "Suspense/Thriller" ]

	validates :isbn, :title, :abstract, :pages, :genre, :published_on, :total_in_library, :author, presence: true
	validates :abstract, length: { minimum: 15 }
	validates :pages, :total_in_library, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :genre, inclusion: { in: GENRES }

	belongs_to :author

	def self.search(query)
	  where("title like ? or isbn like ?", "%#{query}%", "%#{query}%") 
	end
	
	has_many :reservations, dependent: :destroy
end
