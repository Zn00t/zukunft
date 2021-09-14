class AdmincornerController < ApplicationController

  def index
    @users = User.all
    @inactive_users = User.where(active: false)
    @active_users = User.where(active: true)
  end

  def change
    if params["/admincorner"][:method] == "activate"
      User.update(params["/admincorner"][:id], :active => true)
      redirect_to admincorner_path, notice: "#{User.find(params["/admincorner"][:id]).name} wurde aktiviert."
    end
    if params["/admincorner"][:method] == "deactivate"
      User.update(params["/admincorner"][:id], :active => false)
      redirect_to admincorner_path, notice: "#{User.find(params["/admincorner"][:id]).name} wurde deaktiviert."
    end
    if params["/admincorner"][:method] == "add_user"
      if User.find_by_name(params["/admincorner"][:name])
        redirect_to admincorner_path, alert: "Dieser User existiert schon, nochmal checken bidde!" and return
      end
      User.create(:name => params["/admincorner"][:name], :password => "zukunft", :password_confirmation => "zukunft", :admin => false, :active => true)
      FinanceValue.create(:name => params["/admincorner"][:name], :sum => 0, :rate => 0, :food => 0, :invest => 0, :cleaning => 0, :user_id => User.find_by_name(params["/admincorner"][:name]).id, :cleaned => false)
      redirect_to admincorner_path, notice: "#{User.find_by_name(params["/admincorner"][:name]).name} wurde hinzugefügt."
    end
  end

end
