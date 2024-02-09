class HomeController < ApplicationController

  before_action :require_user_logged_in!
  before_action :checkrestacks
  before_action :calcsum

  def index
    @user = User.all
    @non_deleted_users = User.where(:deleted => false)
  end

  def foreign_restack
    if params["/?locale=#{params[:locale]}"][:action] == "accept"
      restack = Restack.find(params["/?locale=#{params[:locale]}"][:restack_id])
      Current.user.receive_money!(amount: restack.value, from: restack.from_id)
      restack.update(prompted: true)
      redirect_to root_path, notice: t('alertValuesUpdated')
    elsif params["/?locale=#{params[:locale]}"][:action] == "decline"
      restack = Restack.find(params["/?locale=#{params[:locale]}"][:restack_id])
      restack.update(prompted: true, Cancelled: true)
      redirect_to root_path, warning: t("transactionDeclined")
    end
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
    Current.user.current_cleaningtask.done!
    redirect_to root_path, notice: t('alertThankYou')
  end

  def checkrestacks
    @pending_restacks = Restack.where(:prompted => false, :to_id => Current.user.id)
  end

  def calcsum
    # do nothing
  end
end
