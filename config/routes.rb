Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :confirmemail] do
    collection do
      post :confirmemail
    end
  end

  resources :sessions, only: [:create]

  resources :tasks do
    collection do
      post :destroychecked
    end
  end
end
