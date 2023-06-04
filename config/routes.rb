Rails.application.routes.draw do
 
  resources :notes do
    resources :comments, only: [:new, :create, :show, :edit, :update, :destroy]
  end
  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
   }

   delete 'notes/:id', to: 'notes#destroy', as: 'delete_note'
   get 'notes', to: 'notes#index', as: 'index_note'
   delete 'notes/:note_id/comments/:id', to: 'comments#destroy', as: 'delete_comment'
   put '/notes/:note_id/comments/:id', to: 'comments#update', as: 'update_comment' 
        
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

end
