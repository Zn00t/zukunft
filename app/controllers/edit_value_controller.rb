class EditValueController < ApplicationController

  def edit
    @values = FinanceValue.find(Current.user.id)
  end

  def update

  end
end
