Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :hardiness_zones, only: [] do
        get :search, on: :collection
      end
    end
  end
end
