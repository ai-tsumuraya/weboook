class Bookmark < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :link, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :note, presence: true, length: { maximum: 1000 }
  
  has_many :keeps
  has_many :reverses_of_keep, class_name: 'Keep', foreign_key: 'bookmark_id'
  has_many :stored_by, through: :reverses_of_keep, source: :user
end
