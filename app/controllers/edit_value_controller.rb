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
end
