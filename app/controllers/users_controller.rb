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
      flash.now[:alert] = "Никнейм уже занят"
      render :new
    end
  end

  def edit
  end

  def update
    if user_params.values.any?(&:blank?)
      flash.now[:alert] = "Пожалуйста, заполните все поля"
      render :edit, status: :unprocessable_entity
    elsif user_params[:password] != user_params[:password_confirmation]
      flash.now[:alert] = "Пароли не совпадают"
      render :edit, status: :unprocessable_entity
    elsif @user.update(user_params.except(:password_confirmation))
      redirect_to games_path, notice: "Данные обновлены"
    else
      flash.now[:alert] = "Никнейм уже занят"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end