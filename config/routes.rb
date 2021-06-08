Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :searches
  get :fetch_data, to: "searches#fetch_data"

  # root 'searches#index'

end
