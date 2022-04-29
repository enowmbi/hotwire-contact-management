# frozen_string_literal: true

class Contact < ApplicationRecord
  has_one_attached :image do |attached_image|
    attached_image.variant :thumb, resize_to_limit: [100, 100]
    attached_image.variant :medium, resize_to_limit: [300, 300]
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { within: (10..40) }, uniqueness: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  validate :acceptable_image

  private

  def acceptable_image
    return unless image.attached?

    errors.add(:image, "is too big") unless image.byte_size <= 1.megabyte

    acceptable_types = ["image/jpeg", "image/png"]
    errors.add(:image, "must be a JPEG or PNG") unless acceptable_types.include?(image.content_type)
  end
end
