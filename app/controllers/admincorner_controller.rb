class AdmincornerController < ApplicationController

  def index
    if Current.user == nil || Current.user.admin == false
      redirect_to root_path, alert: t('alertNotLoggedInAsAdmin') and return
    end
    @users = User.all
    @inactive_users = User.where(active: false)
    @active_users = User.where(active: true)
  end

  def change
    if params["/admincorner?locale=#{params[:locale]}"][:method] == "activate"
      User.update(params["/admincorner?locale=#{params[:locale]}"][:id], :active => true)
      redirect_to admincorner_path, notice: "#{User.find(params["/admincorner?locale=#{params[:locale]}"][:id]).name} #{t('alertWasActivated')}"
    end
    if params["/admincorner?locale=#{params[:locale]}"][:method] == "deactivate"
      User.update(params["/admincorner?locale=#{params[:locale]}"][:id], :active => false)
      redirect_to admincorner_path, notice: "#{User.find(params["/admincorner?locale=#{params[:locale]}"][:id]).name} #{t('alertWasDeactivated')}"
    end
    if params["/admincorner?locale=#{params[:locale]}"][:method] == "add_user"
      if User.find_by_name(params["/admincorner?locale=#{params[:locale]}"][:name])
        redirect_to admincorner_path, alert: "#{t('alertUserAlreadyExists')}" and return
      end
      User.create(:name => params["/admincorner?locale=#{params[:locale]}"][:name], :password => "zukunft", :password_confirmation => "zukunft", :admin => false, :active => true)
      redirect_to admincorner_path, notice: "#{User.find_by_name(params["/admincorner?locale=#{params[:locale]}"][:name]).name} #{t('alertWasAdded')}"
    end
    if params["/admincorner?locale=#{params[:locale]}"][:method] == "admin_checkbox"
      User.update(params["/admincorner?locale=#{params[:locale]}"][:id], :admin => params["/admincorner?locale=#{params[:locale]}"][:admin])
      redirect_to admincorner_path, notice: t('alertUpdatedPermissions') and return
    end
  end

end
