class HomeController < ApplicationController

  before_action :checkrestacks
  before_action :calcsum

  def index
    @value = FinanceValue.all
    @user = User.all
    @userFinanceValue = FinanceValue.find(Current.user.id)
  end

  def foreign_restack
    if Current.user.present?
      receiver_value = FinanceValue.find(@pending_restack.to_id).food - @pending_restack.value
      sender_value = FinanceValue.find(@pending_restack.from_id).food + @pending_restack.value
      FinanceValue.update(@pending_restack.to_id, :food => receiver_value)
      FinanceValue.update(@pending_restack.from_id, :food => sender_value)
      Restack.update(@pending_restack.id, :prompted => true)
      redirect_to root_path, notice: "Werte aktualisiert"
    end
  end

  def away
    away_date = Date.today + (params[:weeks].to_i) * 7
    FinanceValue.update(Current.user.id, :away => away_date)
    redirect_to root_path, notice: "Bis dann #{Current.user.name}!"
  end

  def shopping
    if (params[:value].to_f != 0.0)
      financeValue = FinanceValue.find(Current.user.id)
      updatedFood = financeValue.food - params[:value].to_f
      financeValue.update(food: updatedFood)
      redirect_to root_path, notice: "Danke dir!"
    end

  end

  def checkrestacks
    if Current.user.present?
      @pending_restack = Restack.where(:prompted => false, :to_id => Current.user.id).first
    end
  end

  def calcsum
    FinanceValue.update_all "sum = food + invest + cleaning"
  end
end
