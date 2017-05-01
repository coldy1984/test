Rails.application.routes.draw do
  devise_for :users
  get 'welcome/homepage'
  root 'welcome#homepage'

  resources :repos do
    member do
      post :assign
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
