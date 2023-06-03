Rails.application.routes.draw do
  resources :notes
  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
   }

   delete 'notes/:id', to: 'notes#destroy', as: 'delete_note'
   get 'notes', to: 'notes#index', as: 'index_note'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

end
