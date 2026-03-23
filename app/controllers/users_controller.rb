class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if user_params.values.any?(&:blank?)
      flash.now[:alert] = "Пожалуйста, заполните все поля"
      render :new
    elsif @user.save
      session[:user_id] = @user.id
      redirect_to games_path
    else
      flash.now[:alert] = "Ошибка при регистрации"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to games_path, notice: "Данные обновлены"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
  params.require(:user).permit(:name, :password, :password_confirmation, :security_question, :security_answer)
  end
  
end