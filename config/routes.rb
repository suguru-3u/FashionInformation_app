Rails.application.routes.draw do

  namespace :users do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/new'
  end
  root to: 'users/homes#top'
# デバイスのURL
  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    get '/users/sign_in' => 'users/sessions#new'
    post '/users/sign_in' => 'users/sessions#create'
    delete '/users/sign_out' => 'users/sessions#destroy'
    get '/users/sign_up' => 'users/registrations#new'
    get '/users/passwords/edit' => 'users/registrations#edit'
    patch '/users/passwords/update' => 'users/registrations#update'
    post '/users/sign_up' => 'users/registrations#create'
    get '/users/' => 'users/passwords#edit'
    patch '/users/passwords' => 'users/passwords#update'
    get '/users/passwords/new' => 'users/passwords#new'
  end
# ユーザー側のURL
  namespace :users do
    get 'homes/top' => 'homes#top'
    get 'homes/about' => 'homes#about'
    resource :users, only:[:show,:edit,:update]
    resources :contacts, only: [:new,:create]
    resources :youtube, only: [:index,:create,:destroy]
    get '/users/youtube' => '/users/youtube#favorite'
    resources :posts do
      resources :comments, only: [:create,:destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end


  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'

    authenticated :admin do
      delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
      get 'admins/password/edit' => 'admins/passwords#edit', as: 'edit_admin_password'
      patch 'admins/password' => 'admins/passwords#update', as: 'admin_password'
      get 'admins/passwords/new' => 'admins/password#new', as: 'admin_forgot_password'
    end
  end

  namespace :admins do
    resource :admins, only:[:show,:edit]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
