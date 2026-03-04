class GamesController < ApplicationController
  before_action :set_game, only: [:show, :attempt, :destroy]
  
  def index
    @games = Game.order(created_at: :desc).limit(20)  
  end
  
  def create
    @game = Game.create!(digit_length: params[:digit_length] || 4)
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
      flash[:alert] = "Пожалуйста, введите ровно #{@game.digit_length} цифры"
    elsif guess.chars.uniq.length != @game.digit_length
      flash[:alert] = "Цифры не должны повторяться! Введите #{@game.digit_length} разные цифры"
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
    @game = Game.find(params[:id])
  end
end