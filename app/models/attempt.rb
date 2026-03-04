class Attempt < ApplicationRecord
  belongs_to :game
  
  validates :guess, presence: true
  validates :guess, format: { with: /\A\d+\z/, message: "must be digits only" }
  validates :bulls, presence: true, numericality: { only_integer: true }
  validates :cows, presence: true, numericality: { only_integer: true }
  
  validate :guess_must_have_correct_length
  validate :digits_must_be_unique
  
  private
  
  def guess_must_have_correct_length
    if game && guess.present? && guess.length != game.digit_length
      errors.add(:guess, "should be #{game.digit_length} digits")
    end
  end
  
  def digits_must_be_unique
    if game && guess.present? && guess.chars.uniq.length != game.digit_length
      errors.add(:guess, "цифры не должны повторяться")
    end
  end
end