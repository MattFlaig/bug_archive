class Bug < ActiveRecord::Base
  #include Codelistingable
  	
  belongs_to :category
  belongs_to :user
  has_many :solutions
  has_many :listings, :as => :listingable

  validates_presence_of :name, :description, :environment, :category_id

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    where("name LIKE ?", "%#{search_term}%")
  end
end