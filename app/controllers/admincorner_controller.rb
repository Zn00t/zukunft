class AdmincornerController < ApplicationController
  before_action :enforce_admin_user

  def index
    @users = User.all
    @inactive_users = User.where(active: false)
    @active_users = User.where(active: true)
    @excepted_users = User.where(excepted: true)
    @active_rooms = Room.where(active: true)
    @inactive_rooms = Room.where(active: false)
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
      User.update(
        params["/admincorner?locale=#{params[:locale]}"][:id],
        :admin => params["/admincorner?locale=#{params[:locale]}"][:admin],
        :excepted => params["/admincorner?locale=#{params[:locale]}"][:excepted])
      redirect_to admincorner_path, notice: t('alertUpdatedPermissions') and return
    end

    if params["/admincorner?locale=#{params[:locale]}"][:method] == "delete"
      User.update(params["/admincorner?locale=#{params[:locale]}"][:id], :deleted => true)
      redirect_to admincorner_path, notice: t('alertUpdatedPermissions') and return
    end

    if params["/admincorner?locale=#{params[:locale]}"][:method] == "resetpw"
      User.update(params["/admincorner?locale=#{params[:locale]}"][:id], :password => params["/admincorner?locale=#{params[:locale]}"][:newpw])
      redirect_to admincorner_path, notice: t('alertUpdatedPermissions') and return
    end

    if params["/admincorner?locale=#{params[:locale]}"][:method] == "activate_room"
      Room.find(params["/admincorner?locale=#{params[:locale]}"][:id]).activate!
      redirect_to admincorner_path, notice: "Raum aktiviert" and return
    end

    if params["/admincorner?locale=#{params[:locale]}"][:method] == "deactivate_room"
      Room.find(params["/admincorner?locale=#{params[:locale]}"][:id]).deactivate!
      redirect_to admincorner_path, notice: "Raum deaktiviert" and return
    end

    if params["/admincorner?locale=#{params[:locale]}"][:method] == "add_room"
      if Room.find_by_name(params["/admincorner?locale=#{params[:locale]}"][:name])
        redirect_to admincorner_path, alert: "Den Raum gibts schon!" and return
      end
      Room.create(:name => params["/admincorner?locale=#{params[:locale]}"][:name],
                  :description => params["/admincorner?locale=#{params[:locale]}"][:description])
      redirect_to admincorner_path, notice: "#{Room.find_by_name(params["/admincorner?locale=#{params[:locale]}"][:name]).name} angebaut"
    end

    if params["/admincorner?locale=#{params[:locale]}"][:method] == "delete_room"
      Room.find(params["/admincorner?locale=#{params[:locale]}"][:id]).delete!
      redirect_to admincorner_path, notice: "Raum gelöscht" and return
    end

    if params["/admincorner?locale=#{params[:locale]}"][:method] == "edit_room"
      Room.find(params["/admincorner?locale=#{params[:locale]}"][:id])
          .update_description!(params["/admincorner?locale=#{params[:locale]}"][:newDescription])
      redirect_to admincorner_path, notice: "Beschreibung aktualisiert" and return
    end
  end

  private
  def enforce_admin_user
    if Current.user == nil || Current.user.admin == false
      redirect_to root_path, alert: t('alertNotLoggedInAsAdmin') and return
    end
  end
end
