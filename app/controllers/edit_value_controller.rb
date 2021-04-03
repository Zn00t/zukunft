class EditValueController < ApplicationController

  def edit
    @values = FinanceValue.find(Current.user.id)
  end

  def update
    @values = FinanceValue.find(Current.user.id)
    if @values.update(params.permit(:rate, :food, :invest, :cleaning))
      redirect_to root_path, notice: "Finanzwerte erfolgreich geändert."
    else
      render edit
    end
  end

  def restack
    @value = FinanceValue.find(params[:id])
  end
  def upload_restack
    if params[:value] != "" &&
      Restack.create(from_id: Current.user.id, to_id: params[:id], value: params[:value], user_id: Current.user.id prompted: false)
      redirect_to root_path, notice: "Umschichtung vorgeschlagen."
    else
      redirect_to restack_path, alert: "Bitte gib einen Wert ein."
    end
  end
  end
