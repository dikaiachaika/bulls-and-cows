class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Вы успешно вошли"  # ← Добавьте эту строку
      redirect_to games_path
    else
      flash[:alert] = "Неверное имя или пароль"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end