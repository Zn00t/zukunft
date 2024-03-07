class ApplicationController < ActionController::Base
  before_action :set_current_user
  around_action :switch_locale
  rescue_from ActiveRecord::RecordNotFound, :with => :rescue404
  rescue_from ActionController::RoutingError, :with => :rescue404

  def default_url_options
    { locale: I18n.locale }
  end

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def current_user
    Current.user
  end

  def require_user_logged_in!
    redirect_to sign_in_path, alert: t('alertUserNotLoggedIn') if Current.user.nil?
  end

  def access_denied(exception)
    head :forbidden
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def rescue404
    render plain: "404 Not Found", status: 404
  end

end
