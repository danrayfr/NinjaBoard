# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
# id                          :bigint                         not null, primary key
# email                       :string                         not null, default('')
# encrypted_password          :string                         not null, default('')
# username                    :string
# first_name                  :string
# last_name                   :string
# role                        :integer                        default(0)
# uid                         :string
# avatar_url                  :string
# provider                    :string
#
# Indexes
#
# index_users_on_email                                        (email)
# index_users_on_reset_password_token                         (reset_password_token)
#

class User < ApplicationRecord
  include BuildAssociation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  before_save :sanitize_email
  has_person_name
  has_many :assigned_courses, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_one :badge
  has_one :user_skill_map

  validates :email, presence: true, uniqueness: true

  # Use devise-security instead.
  # Commented password validation for demo and pitch purpose
  # validates :password, presence: true, length: { minimum: 8 },
  #                      format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]) [A-Za-z\d@$!%*?&]+\z/,
  #                                message: 'Must contain at least one uppercase letter,
  #                      one lowercase letter, one special character, and one number' },
  #                      if: :password_required? && :not_omniauth_login?

  enum role: %i[ninja admin]

  after_create :build_user_skill_map_if_missing
  after_create :build_user_badge_if_missing

  def build_user_skill_map_if_missing
    build_association_if_missing(:user_skill_map)
  end

  def build_user_badge_if_missing
    return if badge.present?

    # Create a new user badge for the user
    build_badge.save
  end

  def password_required?
    password.present? || new_record?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.avatar_url = auth.info.image

      # if you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def link_google_account(auth)
    if self.provider.nil? || self.uid.nil?
      self.provider = auth.provider
      self.uid = auth.uid
      self.save!
    end
  end

  def sanitize_email
    email.strip.downcase
  end

  private

  def omniauth_login?
    provider.present? && uid.present?
  end

  def not_omniauth_login?
    !omniauth_login?
  end
end
