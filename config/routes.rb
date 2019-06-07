# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    scope module: :v1, as: :v1, constraints: ApiConstraints::Version.new({version: 1, default: true}) do
      root 'static_pages#index'

      namespace :auth do
        namespace :passengers do
          resources :sessions, only: [:create]
        end
      end

      namespace :flights do
        get '/search' => 'executions#search'

        namespace :reservations do
          resources :reservations, path: '', only: [:create]
        end
      end
    end
  end

  mount Sidekiq::Web, at: '/sidekiq' if Rails.env.development?
end
