Rails.application.routes.draw do
  use_doorkeeper_openid_connect
  use_doorkeeper
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'home#index'

  namespace :api do
    namespace :v1 do
    end 
  end
end
