class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:name])

    if @user
      redirect_to edit_password_reset_path(@user)
    else
      flash[:alert] = "Пользователь не найден"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.security_answer.downcase == params[:security_answer].downcase
      if @user.update(password_params)
        redirect_to login_path, notice: "Пароль обновлён"
      else
        render :edit
      end
    else
      flash.now[:alert] = "Неверный ответ"
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end