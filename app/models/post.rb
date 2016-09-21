class Post < ApplicationRecord
  has_many :comments
  before_save { title.downcase! }
  validates :title, presence: true, length: { maximum: 50 }
  # validates(:title, presence: true)
  validates :content, presence: true, uniqueness: { case_sensitive: false }
end
