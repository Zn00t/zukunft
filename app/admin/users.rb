ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :admin, :active, :rate, :food, :invest, :cleaning, :cleaned, :away, :deleted, :telegram_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :password_digest, :admin, :active, :rate, :food, :invest, :cleaning, :cleaned, :away, :deleted, :telegram_id, :sum]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  

  form do |f|
    f.inputs do
      input :name
      input :active
      input :admin
      input :telegram_id
      input :away
    end
    f.inputs do
      input :rate
      input :food
      input :invest
      input :cleaning
    end

    f.inputs do
      input :cleaned
      input :deleted
    end

    f.actions
  end

  index do
    id_column
    column :name
    toggle_bool_column :admin
    toggle_bool_column :active
    column :telegram_id
    column :away
    column :cleaned
    actions
  end
end
