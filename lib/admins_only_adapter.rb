class AdminsOnlyAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    user&.admin?
  end
end
