Rails.application.routes.draw do
  resources :rooms, :only => :index do
    resources :users, :only => [:index, :create, :destroy]
    resources :logs, :only => [:index, :create]
  end

  root :to => 'top#index'
end
