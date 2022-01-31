Rails.application.routes.draw do
  root to: 'api/v1/pokemon#index'
  namespace :api, defaults: { format: 'json' } do
    namespace 'v1' do
      resources :pokemon
    end
  end
end
