# frozen_string_literal: true

class User < ApplicationRecord
  include BuildAssociation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  before_save :sanitize_email
  has_person_name
  has_many :courses, dependent: :destroy
  has_many :assigned_courses, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_one :badge
  has_one :user_skill_map

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 },
                       format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+\z/,
                                 message: 'Must contain at least one uppercase letter,
                       one lowercase letter, one special character, and one number' },
                       if: :password_required?
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

  def sanitize_email
    email.strip.downcase
  end
end
