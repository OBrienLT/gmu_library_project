class Reservation < ActiveRecord::Base
  before_save :set_dates
  belongs_to :user
  belongs_to :book

  scope :overduebooks, -> { where('due_on < ?', Time.now.to_date) }

  protected

  def set_dates
  	self.reserved_on = Date.today()
    self.due_on = Date.today() + 5
  end
end
