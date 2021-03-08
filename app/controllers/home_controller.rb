class HomeController < ApplicationController
  def index
    @value = FinanceValue.all
    @user = User.all
  end
end
