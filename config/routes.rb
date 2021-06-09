Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'

  resources :channels, except: [:index]
  resources :forums, except: [:index]
  resources :forum_threads, path: 'threads' do
    resources :forum_replies, shallow: true, path: 'replies'
  end

  
  get '/forums', to: 'channels#index'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { registrations: 'registrations' }
end
