class SessionsController < ApplicationController

  def new

  end
  def create
    user = User.find_by(name: params[:name])
    if user.present? && user.authenticate(params[:password]) && !user.deleted
      session[:user_id] = user.id
      redirect_to root_path, notice: t('alertLoggedInSuccessfully')
    else
      flash[:alert] = t('alertWrongCredentials')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('alertLoggedOut')
  end
end
