# config valid only for current version of Capistrano
# lock '3.6.1'

server 'vps344707.ovh.net', port: 22, roles: [:web, :app, :db], primary: true

set :application,     'cindysauvain'
set :repo_url,        'git@github.com:G33X/cindysauvain.git'
set :user,            'gmsrd'
set :ruby_version,    'ruby-2.3.1-p112'

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')


# set :passenger_environment_variables, { path: '/path-to-passenger/bin:$PATH' }
# set :passenger_restart_command, '/path-to-passenger/bin/passenger-config restart-app'

set :passenger_restart_with_touch, false

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
	desc "Make sure local git is in sync with remote."
	after  :restart, :clear_cache do
		on roles(:web), in: :groups, limit: 3, wait: 10 do
		end
	end
end


	before :starting,       :check_revision
	after  :finishing,      :compile_assets
	after  :finishing,      :cleanup
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
