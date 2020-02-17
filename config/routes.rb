Rails.application.routes.draw do
  #デフォルトページのルーティング
  get '', to: 'sessions#new'
  
  #写真投稿機能のルーティング
  resources :posts do
    collection do
      post :confirm
    end
  end

  #セッション管理機能のルーティング
  resources :sessions, only: [:new, :create, :destroy]

  #ユーザー管理機能のルーティング
  resources :users

end
