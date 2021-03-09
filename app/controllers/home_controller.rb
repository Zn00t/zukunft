class HomeController < ApplicationController

  before_action :calcsum

  def index
    @value = FinanceValue.all
    @user = User.all
  end

  def calcsum
    FinanceValue.update_all "sum = food + invest + cleaning"
  end
end
