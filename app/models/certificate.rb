# frozen_string_literal: true

# == Schema Information
#
# Table name: certificates
#
# id                          :bigint                         not null, primary key
# title                       :string
# source                      :integer                        not null, default(0)
# date_awarded                :datetime
#
# Indexes
#
# index_certificates_on_user_id                               (user_id)
#
# Foreign key
#
# fk_rails ... (user_id => user.id)
#

class Certificate < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }, uniqueness: { scope: :user_id }
  enum source: %i[default linkedin udemy other]
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
