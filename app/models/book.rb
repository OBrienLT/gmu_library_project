class Book < ActiveRecord::Base
	belongs_to :author

	def self.search(query)
	  where("title like ? or isbn like ?", "%#{query}%", "%#{query}%") 
	end
end
