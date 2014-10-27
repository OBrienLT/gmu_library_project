class Book < ActiveRecord::Base
	
	GENRES = %w(Sci-Fi Fiction Non-Fiction Tragedy Mystery Fantasy Mythology)

	validates :isbn, :title, :abstract, :pages, :genre, :published_on, :total_in_library, presence: true
	validates :abstract, length: { minimum: 15 }
	validates :pages, :total_in_library, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :genre, inclusion: { in: GENRES }

	def self.search(query)
		search_string = "%" + query + "%"
	  where("books.title like ? OR books.isbn like ? OR authors.name like ?", search_string, search_string, search_string) 
	end
	
  belongs_to :author, foreign_key: 'author_id'
  validates_presence_of :author
	has_many :reservations, dependent: :destroy
	has_many :users, :through => :reservations

	before_validation :set_selected_author

	private
  def set_selected_author
    if author_id && author_id != '0'
      self.author = Author.find(author_id)
    end
  end
end
