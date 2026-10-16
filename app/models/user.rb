class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet
  validates :uid, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, length: { maximum: 72 }, allow_nil: true

  attr_reader :password

  def password=(value)
    @password = value
    self.pass = BCrypt::Password.create(value) if value.present?
  end

  def authenticate(password)
    return false if pass.blank?

    BCrypt::Password.new(pass).is_password?(password) ? self : false
  rescue BCrypt::Errors::InvalidHash
    false
  end
end