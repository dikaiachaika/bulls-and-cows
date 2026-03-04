class Game < ApplicationRecord
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
  
  # Логируем входящие данные
  puts "=" * 50
  puts "check_guess called:"
  puts "guess: #{guess} (#{guess.class})"
  puts "secret_number: #{secret_number} (#{secret_number.class})"
  puts "digit_length: #{digit_length}"
  puts "secret_number length: #{secret_number.length}"
  
  guess.to_s.chars.each_with_index do |digit, index|
    puts "digit #{index}: #{digit} comparing with secret_number[#{index}]: #{secret_number[index]}"
    
    if digit == secret_number[index]
      bulls += 1
      puts "  -> BULL! bulls now: #{bulls}"
    elsif secret_number.include?(digit)
      cows += 1
      puts "  -> COW! cows now: #{cows}"
    else
      puts "  -> nothing"
    end
  end
  
  attempt = attempts.create(guess: guess, bulls: bulls, cows: cows)
  puts "Attempt created: #{attempt.valid? ? 'valid' : 'invalid'} #{attempt.errors.full_messages}"
  puts "Bulls: #{bulls}, digit_length: #{digit_length}, bulls == digit_length? #{bulls == digit_length}"
  
  if bulls == digit_length
    puts "VICTORY! Updating status to won"
    update(status: 'won', completed_at: Time.current)
  else
    puts "No victory yet"
  end
  
  puts "=" * 50
  
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