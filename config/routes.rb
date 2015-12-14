Rails.application.routes.draw do
  resources :rooms, :only => :index do
    resources :users, :only => [:index, :create, :destroy]
  end
  resources :room_logs, :only => :index

  root :to => 'top#index'
end
