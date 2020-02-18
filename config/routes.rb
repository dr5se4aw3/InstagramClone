Rails.application.routes.draw do
  #開発環境用レターオープナーのルーティング
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  #デフォルトページのルーティング
  get '', to: 'sessions#new'

  #写真投稿機能のルーティング
  resources :posts do
    collection do
      post :confirm
    end
  end

  #お気に入り機能のルーティング
  resources :favorites, only: [:create, :destroy]

  #セッション管理機能のルーティング
  resources :sessions, only: [:new, :create, :destroy]

  #ユーザー管理機能のルーティング
  resources :users

end
