Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "businesses#index"

  resources :businesses do
    member do
      get 'dashboard'
    end
    
    resources :customers
  end

  get "/settings/account", to: "settings#index", as: :settings
  get "/settings/account_information", to: "settings#account_information", as: :account_information_settings
  get "/settings/password", to: "settings#password", as: :password_settings
  get "/settings/email", to: "settings#email", as: :email_settings
  get "/settings/name", to: "settings#name", as: :name_settings
  patch "/settings/name", to: "settings#update_name", as: :update_name_settings
  get "/settings/deactivate_account", to: "settings#deactivate_account", as: :deactivate_account_settings
end
