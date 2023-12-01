class User < ApplicationRecord
  has_many :documents
  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password_confirmation, presence: true

  def welcome
    "Sveiks, #{self.username}"
  end
end
