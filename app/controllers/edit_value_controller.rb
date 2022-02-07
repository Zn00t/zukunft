class EditValueController < ApplicationController

  def edit
  end

  def update
    if Current.user.update(params.permit(:rate, :food, :invest, :cleaning, :cleaned))
      redirect_to root_path, notice: "Finanzwerte erfolgreich geändert."
    else
      render edit
    end
  end

  def restack
  end

  def upload_restack
    if params[:value] != "" &&
      Restack.create(from_id: Current.user.id, to_id: params[:id], value: params[:value], user_id: Current.user.id, prompted: false)
      redirect_to root_path, notice: "Umschichtung vorgeschlagen."
    else
      redirect_to restack_path, alert: "Bitte gib einen Wert ein."
    end
  end
end
