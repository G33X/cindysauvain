require 'socket'
require 'rails'

# workers 1
# threads 1, 6

# app_dir = File.expand_path('../..', __FILE__)
# shared_dir = "#{app_dir}/shared"

# rails_env = ENV['RAILS_ENV'] || 'production'
# environment rails_env


# Local env
if Socket.gethostname == 'iMac.local' &&
	 Rails.env == 'production'

	secure_path = ENV['SECURE_PATH']
	path_to_key = secure_path + 'localhost.key'
	path_to_cert = secure_path + 'localhost.crt'

	ssl_bind '127.0.0.1', '5000', {
			key: path_to_key,
			cert: path_to_cert
	}

else
	# bind "unix://#{shared_dir}/sockets/puma.sock"
	# daemonize
end

# stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
# pidfile "#{shared_dir}/pids/puma.pid"
# state_path "#{shared_dir}/pids/puma.state"
# activate_control_app

# on_worker_boot do
# 	require 'active_record'
# 	ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
# 	ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
# end

lowlevel_error_handler do |e, env|
	[500, {}, ['Server error\n We\'re sorry! The server encountered an internal error and was unable to complete your request. The administrator has been notified. Please try again later.']]
	Rails.logger = Le.new('bed0e936-490a-4e6b-b5f1-ec20de69ee80', :debug => true, :local => true)
	Rails.logger.warn("Environment: #{env}\n Puma caught this error: #{e.message} (#{e.class})\n#{e.backtrace.join("\n")}")
end
