# typed: strict
# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'

  root to: 'home#index'

  resources :advisories, only: :index
end
