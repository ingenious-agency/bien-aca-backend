# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users, only: %i[create] do
    resources :heartbeats, only: %i[create]
  end

  post '/auth/login', to: 'authentication#login'
end
