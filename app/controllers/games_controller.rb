class GamesController < ApplicationController
  before_action :require_login
  before_action :set_game, only: [:show, :attempt, :destroy]
  
  def index
    @games = current_user.games.order(created_at: :desc).limit(20)

    @records = Game
      .where(status: 'won')
      .includes(:user)
      .sort_by(&:time_spent)
      .first(10)
  end
  
  def create
    @game = current_user.games.create!(digit_length: params[:digit_length] || 4)
    redirect_to @game
  end
  
  def show
    @attempt = Attempt.new
  end
  
  def attempt
    guess = params[:guess].to_s.strip

    if guess.blank?
      flash[:alert] = "Пожалуйста, введите число"
    elsif !guess.match?(/\A\d{#{@game.digit_length}}\z/)
      flash[:alert] = "Пожалуйста, введите ровно #{@game.digit_length} цифр"
    elsif guess.chars.uniq.length != @game.digit_length
      phrase = digit_phrase(@game.digit_length)
      flash[:alert] = "Цифры не должны повторяться! Введите #{@game.digit_length} #{phrase[:different]} #{phrase[:word]}"
    else
      @game.check_guess(guess)
      
      if @game.status == 'won'
        flash[:notice] = "Поздравляем! Вы угадали число #{@game.secret_number} за #{@game.formatted_time}!"
      elsif @game.max_attempts_reached?
        @game.update(status: 'lost', completed_at: Time.current)
        flash[:alert] = "Игра окончена! Вы использовали все попытки. Загаданное число: #{@game.secret_number}"
      end
    end
    
    redirect_to @game
  end
  
  def destroy
    @game.destroy
    flash[:notice] = "Игра успешно удалена"
    redirect_to games_path
  end
  
  private
  
  def set_game
    @game = current_user.games.find(params[:id])
  end
end