Easyblog::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    member do
      post :mark_archived
    end
  end

  resources :comments
  post "vote_up/:id", controller: "votes", action: "vote_up", as: :vote_up
  post "vote_down/:id", controller: "votes", action: "vote_down", as: :vote_down
  post "mark_as_not_abusive/:id", controller: "votes", action: "mark_as_not_abusive", as: :mark_as_not_abusive
end
