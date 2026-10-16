class Profile < ApplicationRecord
  belongs_to :user

  validates :message, presence: true
  validates :user_id, uniqueness: true
end