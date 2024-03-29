class EditValueController < ApplicationController

  def edit
  end

  def update
    if Current.user.admin? && User.find(params[:id]).update(params.permit(:rate, :food, :invest, :cleaning, :cleaned))
      redirect_to root_path, notice: "Finanzwerte erfolgreich geändert."
    elsif Current.user.update(params.permit(:rate, :food, :invest, :cleaning, :cleaned))
      redirect_to root_path, notice: t('alertValuesChanged')
    else
      render edit
    end
  end

  def upload_restack
    if params[:value].to_i > 0 &&
      Restack.create(from_id: Current.user.id, to_id: params[:id], value: params[:value], user_id: Current.user.id, prompted: false)
      redirect_to root_path, notice: t('alertTransactionSuggested')
    else
      redirect_to root_path, alert: t('alertProvideValue')
    end
  end
end
