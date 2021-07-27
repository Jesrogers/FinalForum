Rails.application.routes.draw do
  match "404", to: "errors#not_found", via: :all
  match "500", to: "errors#internal_server_error", via: :all

  root "pages#home"

  resources :channels, except: [:index]

  resources :forums, except: [:index] do
    resources :forum_threads, path: "threads", only: [:new, :create]
  end

  resources :forum_threads, path: "threads", except: [:index, :new, :create] do
    resources :forum_replies, shallow: true, path: "replies", except: [:index, :show, :new]
  end

  get "/forums", to: "channels#index"
  get "/latest", to: "pages#latest"

  devise_for :users, path: "",
                     path_names: { sign_in: "login", sign_out: "logout", sign_up: "register", edit: "account" }, controllers: { registrations: "registrations", sessions: "sessions" }
  resources :users, only: [:show]
end
