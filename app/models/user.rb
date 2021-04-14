class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  
  has_many :bookmarks
  has_many :keeps
  has_many :stores, through: :keeps, source: :bookmark
  
  def store(stored_bookmark)
    self.keeps.find_or_create_by(bookmark_id: stored_bookmark.id)
  end
  
  def unstore(stored_bookmark)
    keep = self.keeps.find_by(bookmark_id: stored_bookmark.id) 
    keep.destroy if keep
  end
  
  def stored?(stored_bookmark)
    self.stores.include?(stored_bookmark)
  end
  
  def count_stored()
    puts self.stores.count()
  end
end
