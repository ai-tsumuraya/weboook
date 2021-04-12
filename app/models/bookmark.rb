class Bookmark < ApplicationRecord
  belongs_to :user
  
  validates :title, :link, presence: true, length: { maximum: 255 }
  validates :note, presence: true, length: { maximum: 1000 }
  
  has_many :keeps
  has_many :reverses_of_keep, class_name: 'Keep', foreign_key: 'bookmark_id'
  has_many :saved_by, through: :reverses_of_keep, source: :user
end
