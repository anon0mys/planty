Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, controllers: {
                          sessions: :sessions,
                          registrations: :registrations
                         },
                         path_names: { sign_in: :login, sign_out: :logout }
    end
  end

  namespace :api do
    namespace :v1 do
      resources :seeds, only: [:index]
      resources :seed_catalogs, only: [:create, :index, :update, :destroy]
    end
  end
end
