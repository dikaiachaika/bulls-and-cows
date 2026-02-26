class GamesController < ApplicationController
  before_action :set_game, only: [:show, :attempt, :destroy]
  
  def index
    @games = Game.order(created_at: :desc).limit(20)  
  end
  
  def create
    @game = Game.create!
    redirect_to @game
  end
  
  def show
    @attempt = Attempt.new
  end
  
  def attempt
  guess = params[:guess].to_s.strip
  
  if guess.blank?
    flash[:alert] = "Пожалуйста, введите число"
  elsif !guess.match?(/\A\d{4}\z/)
    flash[:alert] = "Пожалуйста, введите ровно 4 цифры (без пробелов и букв)"
  elsif guess.chars.uniq.length != 4
    flash[:alert] = "Цифры не должны повторяться! Введите 4 разные цифры"
  else
    @game.check_guess(guess)
    
    if @game.status == 'won'
      flash[:notice] = "Поздравляем! Вы угадали число #{@game.secret_number}!"
    elsif @game.max_attempts_reached?
      @game.update(status: 'lost')
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