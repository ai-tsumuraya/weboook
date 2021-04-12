class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :bookmarks
  has_many :keeps
  has_many :saves, through: :keeps, source: :bookmark
  
  def save(saved_bookmark)
    self.keeps.find_or_create_by(bookmark_id: saved_bookmark.id)
  end
  
  def unsave(saved_bookmark)
    keep = self.keeps.find_by(bookmark_id: saved_bookmark.id) 
    keep.destroy if keep
  end
  
  def saved?(saved_bookmark)
    self.saves.include?(saved_bookmark)
  end
end
