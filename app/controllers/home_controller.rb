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
    redirect_to root_path, notice: "Werte aktualisiert"
  end

  def away
    away_date = Date.today + (params[:weeks].to_i) * 7
    Current.user.mark_away!(until: away_date)
    redirect_to root_path, notice: "Bis dann #{Current.user.name}!"
  end

  def shopping
    if (params[:value].to_f > 0.0)
      Current.user.shopped_food(amount: params[:value].to_f)
      redirect_to root_path, notice: "Danke dir!"
    end
  end

  def cleaning
    Current.user.cleaned!
    redirect_to root_path, notice: "Danke!"
  end

  def checkrestacks
    @pending_restack = Restack.where(:prompted => false, :to_id => Current.user.id).first
  end

  def calcsum
    # do nothing
  end
end
