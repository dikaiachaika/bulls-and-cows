class Game < ApplicationRecord
  has_many :attempts, dependent: :destroy
  
  validates :secret_number, presence: true, length: { is: 4 }
  validates :status, inclusion: { in: ['active', 'won', 'lost'] }
  
  before_validation :generate_secret_number, on: :create
  
  def check_guess(guess)
    bulls = 0
    cows = 0
    
    guess.chars.each_with_index do |digit, index|
      if digit == secret_number[index]
        bulls += 1
      elsif secret_number.include?(digit)
        cows += 1
      end
    end
    
    attempts.create(guess: guess, bulls: bulls, cows: cows)
    
    if bulls == 4
      update(status: 'won')
    end
    
    bulls
  end
  
  def max_attempts_reached?
    attempts.count >= 10
  end
  
  private
  
  def generate_secret_number
    self.secret_number ||= (0..9).to_a.sample(4).join
    self.status ||= 'active'
  end
end