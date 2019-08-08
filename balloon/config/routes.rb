Rails.application.routes.draw do
  # get 'goals/new'
  # get 'goals/index'
  # get 'goals/create'
  # get 'goals/destroy'
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  # get 'users/new'
  # get 'users/create'
  # get 'users/show'

  resources :users, only: [:new, :create, :show] do
    resources :goals, only: [:new, :index, :create, :destroy, :edit]
  end
  resources :goals, only: [:index]
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
