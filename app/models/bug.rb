class Bug < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :solutions

  validates_presence_of :name, :description, :environment, :category_id

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    where("name LIKE ?", "%#{search_term}%")
  end
end