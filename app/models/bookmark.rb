class Bookmark < ApplicationRecord
  belongs_to :user
  
  validates :title, :link, presence: true, length: { maximum: 255 }
  validates :note, presence: true, length: { maximum: 1000 }
end
