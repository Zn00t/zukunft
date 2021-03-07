class HomeController < ApplicationController
  def index
    flash[:notice] = "Finanzeintrag gespeichert."
    flash[:alert] = "Das hat nicht geklappt :("
  end
end
