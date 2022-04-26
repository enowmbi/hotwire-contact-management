class Contact < ApplicationRecord
  has_one_attached :image

  # validates :name, presence: true, length: {within: (10..40)}, uniqueness: true
  # validates :email, presence: true, 
end
