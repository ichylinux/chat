Rails.application.routes.draw do
  resources :rooms, :only => :index do
    resources :users, :only => [:index, :create, :destroy]
  end
end
