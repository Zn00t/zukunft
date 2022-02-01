Rails.application.routes.draw do

  root 'home#index'

  get "password", to: "passwords#edit", as: "edit_password"
  patch "password", to: "passwords#update"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"

  get "edit/:id", to: "edit_value#edit", as: "edit"
  patch "edit/:id", to: "edit_value#update"
  put "edit/:id", to: "edit_value#update"

  patch "/shopping", to: "home#shopping"
  patch "/cleaning", to: "home#cleaning"

  get "restack/:id", to: "edit_value#restack", as: "restack"
  post "restack/:id", to: "edit_value#upload_restack", as: "upload_restack"
  patch "/", to: "home#foreign_restack"
  post "/", to: "home#foreign_restack", as: "foreign_restack"

  put "/", to: "home#away"

  get "admincorner", to: "admincorner#index", as: "admincorner"
  post "admincorner", to: "admincorner#change", as: "admincorner_change"
end

