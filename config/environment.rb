# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'socket'

##ENV['SECRET_KEY_BASE'] = "#{SECRET_KEY_BASE}:/Users/G33X/.bashrc"

# Initialize the Rails application.
Rails.application.initialize!

# Logentries logging
Rails.logger = Le.new('bed0e936-490a-4e6b-b5f1-ec20de69ee80', :debug => true, :local => true)

Rails.logger.info('The app on ' + Socket.gethostname + ' has been reloaded !')
# Rails.logger.warn('Look at me, I'm a warning message')
# Rails.logger.debug('Look at me, I'm a debug message')
