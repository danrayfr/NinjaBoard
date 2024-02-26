# frozen_string_literal: true

class Certificate < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: true, length: { maximum: 100 }
  enum source: %i[default linkedin udemy coursera]
  validates :date_awarded, presence: true

  has_one_attached :file
  validates :file, presence: true
  validate :validate_file_content_type

  private

  def validate_file_content_type
    return unless file.attached? && !file.content_type.in?(%w[image/jpeg image/png])

    errors.add(:file, 'must be a PNG or JPEG file.')
  end
end
