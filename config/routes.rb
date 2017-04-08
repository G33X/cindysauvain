require 'socket'

Rails.application.routes.draw do

	https_host = 'https://www.cindysauvain.com'
	#
	# # Redirects the main domain to his www subdomain
	if Rails.env.production? &&
		 Socket.gethostname != 'MacBook-Pro-13.local'

		constraints subdomain: '' do
			get '*path', to: redirect(https_host + '/%{path}')
		end
	end


	# Frontend website routes
	# get '/', to: redirect("/#{I18n.locale}")
	root controller: :home, action: :index, locale: I18n.locale

	get '/:locale/itinerary/archive'  =>  'agenda#archive', as: :agenda_archive_en, locale: 'en'
	get '/:locale/agenda/archive'     =>  'agenda#archive', as: :agenda_archive_fr, locale: 'fr'

	localized do
		resources :home,            only:  :index, :path => '/:locale'
		resources :home,            only:  :show, :path => '/:locale/:id'
		resources :agenda,          only: [:index, :show]
		resources :about,           only:  :index
		resources :medias,          only:  :index
		resources :testimonials,    only:  :index
		resources :donate,          only:  :index
		resources :invites,         only:  :create
		resources :links,           only:  :index

		scope constraints: {format: :json} do
			resources :info,            only:  :index
			resources :website,         only:  :index
		end

		resources :privacy_policy,  only:  :index, :path => '/:locale/privacy-policy'
	end


	# Backend website routes
	get '/admin', to: redirect('/casein/news')
	get '/casein', to: redirect('/casein/news')

	namespace :casein do
		resources :news
		resources :events
		resources :medias
		resources :testimonials
	end


	# Mounting of Let's Encrypt plugin
	mount LetsencryptPlugin::Engine => '/'


	# if Rails.configuration
	# CKEditor
	# mount Ckeditor::Engine => '/ckeditor'


	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
end
