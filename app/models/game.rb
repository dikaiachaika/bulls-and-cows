class Game < ApplicationRecord
  belongs_to :user
  has_many :attempts, dependent: :destroy
  
  validates :secret_number, presence: true, length: { is: :digit_length }
  validates :digit_length, presence: true, inclusion: { in: [3, 4, 5, 6] }
  validates :status, inclusion: { in: ['active', 'won', 'lost'] }
  
  before_validation :generate_secret_number, on: :create
  
  attr_accessor :game_time 
  
  def safe_digit_length
    digit_length || 4
  end
  
  def check_guess(guess)
    bulls = 0
    cows = 0
    
    guess.to_s.chars.each_with_index do |digit, index|
      if digit == secret_number[index]
        bulls += 1
      elsif secret_number.include?(digit)
        cows += 1
      end
    end
    
    attempt = attempts.create(guess: guess, bulls: bulls, cows: cows)
    
    if bulls == digit_length
      update(status: 'won', completed_at: Time.current)
    end
    
    bulls
  end
  
  def max_attempts_reached?
    attempts.count >= 10
  end
  
  def time_spent
    return 0 unless started_at
    end_time = completed_at || Time.current
    (end_time - started_at).to_i
  end
  
  def formatted_time
    total_seconds = time_spent
    minutes = total_seconds / 60
    seconds = total_seconds % 60
    format("%02d:%02d", minutes, seconds)
  end
  
  private
  
  def generate_secret_number
    self.digit_length ||= 4
    self.secret_number ||= (0..9).to_a.sample(digit_length).join
    self.status ||= 'active'
    self.started_at ||= Time.current
  end
end