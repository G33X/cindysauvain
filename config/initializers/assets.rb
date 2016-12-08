# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
#Rails.application.config.assets.paths << '/assets/images/social-icons'

# Rails.application.config.assets.precompile += %w( ckeditor/* defer.js.erb )

Rails.application.config.secret_key_base = ENV['SECRET_KEY_BASE']
Rails.application.config.secret_token = ENV['SECRET_TOKEN']

# Rails.application.config.assets.precompile += %w( vimeo.js )