Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  get 'welcome/upload'
  post 'welcome/upload'

	resources :reports, only: [:index, :show]
	get 'reports/show'
end
