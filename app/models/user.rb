class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :password, length: { minimum: 6, maximum: 20 }
  has_many :games
end