class SessionsController < ApplicationController

  def new

  end
  def create
    user = User.find_by(name: params[:name])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Erfolgreich eingeloggt."
    else
      flash[:alert] = "Name oder Passwort falsch."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Du bist nun ausgeloggt."
  end
end