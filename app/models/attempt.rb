class Attempt < ApplicationRecord
  belongs_to :game
  
  validates :guess, presence: true, length: { is: 4 }
  validates :guess, format: { with: /\A\d{4}\z/, message: "must be 4 digits" }
  validates :bulls, presence: true, numericality: { only_integer: true }
  validates :cows, presence: true, numericality: { only_integer: true }
  
  validate :digits_must_be_unique
  
  private
  
  def digits_must_be_unique
    if guess.present? && guess.chars.uniq.length != 4
      errors.add(:guess, "цифры не должны повторяться")
    end
  end
end