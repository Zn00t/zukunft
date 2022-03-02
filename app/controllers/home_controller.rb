class HomeController < ApplicationController

  before_action :require_user_logged_in!
  before_action :checkrestacks
  before_action :calcsum

  def index
    @user = User.all
  end

  def foreign_restack
    Current.user.receive_money!(amount: @pending_restack.value, from: @pending_restack.from_id)
    @pending_restack.update(prompted: true)
    redirect_to root_path, notice: t('alertValuesUpdated')
  end

  def away
    away_date = params[:return_date]
    Current.user.mark_away!(until_date: away_date)
    redirect_to root_path, notice: "#{t('alertSeeYa')} #{Current.user.name}!"
  end

  def shopping
    if (params[:value].to_f > 0.0)
      Current.user.shopped_food(amount: params[:value].to_f)
      redirect_to root_path, notice: t('alertThankYou')
    end
  end

  def cleaning
    Current.user.cleaned!
    redirect_to root_path, notice: t('alertThankYou')
  end

  def checkrestacks
    @pending_restack = Restack.where(:prompted => false, :to_id => Current.user.id).first
  end

  def calcsum
    # do nothing
  end
end
