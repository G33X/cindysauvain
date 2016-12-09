source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2'

# Use Slim as template engine
gem 'slim', '~> 3.0.3'

# Use SASS for stylesheets
gem 'sass-rails', '~> 5.0.3'

# Use Susy for the grid system
gem 'susy', '~> 2.2.3'

# Use Bourbon as SASS toolbox
gem 'bourbon', '~> 4.2.2'

# Breakpoint to manage the breakpoints for media queries easily
gem 'breakpoint', '~> 2.5.0'

# YUI to compress CSS file
gem 'yui-compressor'

# Google Closure Compiler for a better and faster JavaScript
gem 'closure-compiler', '~> 1.1.12'

# Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
# gem 'jquery-rails', '~> 4.1.1'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '~> 2.5.3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Font Awesome
gem 'font-awesome-sass'

# Modal plugin
gem 'magnific-popup-rails', '~> 0.9.9.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Lazyload for images
gem 'lazyload-rails', '~> 0.3.1'

# MediaElementJs
gem 'mediaelement_rails'

# Email encoder
gem 'actionview-encoded_mail_to', '~> 1.0.5'

# Use Casein for the CRUD
gem 'casein', '~> 5.1.1.5'

# gem 'carrierwave', '~> 1.0.0'
# gem 'paperclip', '~> 4.2.1'
# gem 'ckeditor', '~> 4.1.1'

# Routes translation
gem 'route_translator', '~> 4.0.0'

# Mailgun
gem 'mailgun-ruby', '~>1.0.3', require: 'mailgun'

# Livereload
group :development do
	gem 'guard', '~> 2.12.7', :require => false
	gem 'guard-livereload', '~> 2.4.0', :require => false
	# gem 'guard-rails', '~> 0.7.1'
	# gem 'guard-bundler', '~> 2.1.0'
	# gem 'guard-passenger', '~> 0.6.0'
	gem 'rack-livereload', '~> 0.3.16'
	gem 'rb-fsevent', '~> 0.9.5', :require => false

	# Capistrano
	gem 'capistrano',         require: false
	gem 'capistrano-rvm',     require: false
	gem 'capistrano-rails',   require: false
	gem 'capistrano-bundler', require: false
	gem 'capistrano3-puma',   require: false
end

group :production, :production_local do
	# Use PostgreSQL as the database for Active Record
	gem 'pg', '~> 0.18.1'

	# To enable features such as static asset serving and logging on Heroku
	gem 'rails_12factor', '~> 0.0.3'

	# To enable Rails assets pipeline
	gem 'sprockets', '~> 2.11.3'

	# Caching
	gem 'actionpack-page_caching'
	gem 'actionpack-action_caching'

	# SSL certificate generator
	gem 'letsencrypt_plugin'
end

# Logging
gem 'le'

gem 'responders', '~> 2.1.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Web server
gem 'puma', '~> 2.11.2'
# gem 'passenger', '~> 5.0.7'
# gem 'unicorn'

group :development, :test do
	# Use Capistrano for deployment
	# gem 'capistrano', '~> 3.4'
	# gem 'capistrano-rails', '~> 1.1'

	# Favicons generator
	gem 'rails_real_favicon'

	# Use sqlite3 as the database for Active Record
	gem 'sqlite3', '~> 1.3.10'

	# Call 'byebug' anywhere in the code to stop execution and get a debugger console
	gem 'byebug', '~> 4.0.5'

	# Access an IRB console on exception pages or by using <%= console %> in views
	gem 'web-console', '~> 2.1.2'

	# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring', '~> 1.3.5'
end
