require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

require 'susy'
require 'bourbon'
# require "rails/test_unit/railtie"

require 'rubygems'
require 'closure-compiler'
#Closure::Compiler.new.compile(File.open('app/assets/javascripts/application.js', 'r'))
ActiveSupport::Gzip.compress('app/assets/javascripts/application.js')

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cindysauvain
	class Application < Rails::Application

		config.i18n.default_locale = :en
		config.i18n.fallbacks = true
		config.time_zone = 'Europe/Zurich'

		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.

		# Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
		# Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
		# config.time_zone = 'Central Time (US & Canada)'

		# The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
		# config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
		# config.i18n.default_locale = :de

		config.middleware.use Rack::Deflater

		config.assets.enabled = true
		# config.assets.precompile += %w(
		#   '*.css'
		#   '*.js'
		# )

		# Environment variables settings
		config.before_configuration do
			env_file = File.join(Rails.root, 'config', 'local_env.yml')
			YAML.load(File.open(env_file)).each do |key, value|
				ENV[key.to_s] = value
			end if File.exists?(env_file)
		end


		RouteTranslator.config do |config|
			config.force_locale = true
			config.locale_param_key = :locale
		end



		# Do not swallow errors in after_commit/after_rollback callbacks.
		config.active_record.raise_in_transactional_callbacks = true
		# config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

		# config.serve_static_files = true
		#
		# config.assets.initialize_on_precompile = false
	end
end
