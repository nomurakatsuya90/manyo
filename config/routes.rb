Rails.application.routes.draw do
  resources :tasks do
    # collection do
    #   post :confirm
    # end
  end
  root to: 'tasks#index'
  # get 'tasks/index'
  # get 'tasks/new'
  # get 'tasks/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
