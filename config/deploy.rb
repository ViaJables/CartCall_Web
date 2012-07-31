#require "delayed/recipes"
require 'deploy/assets'
#require "bundler/capistrano"
#require "capistrano_database"
require "rvm/capistrano"

set :application, "cartcaller"
set :repository,  "git@github.com:rewardsforce/FlopBots-Web.git"
set :user, "fb"
set :rvm_ruby_string, 'ruby-1.9.2@flopbots'

set :stages, %w(production sandbox)
set :default_stage, "sandbox"

require 'capistrano/ext/multistage'

set :scm, :git
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

set :use_sudo, true
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :chmod755, "app config db lib public vendor script script/* public/ disp*"

task :link_database do
  run "cp -f #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml"
  run "cp -f #{deploy_to}/current/config/delayed_job.monit #{deploy_to}/shared/config/delayed_job.monit"
end

after "deploy:create_symlink", :link_database

namespace :deploy do
  #Passenger/Mod-Rails
  task :restart, :roles => :web do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      #from = source.next_revision(current_revision)
      #if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      #else
      #  logger.info "Skipping asset pre-compilation because there were no asset changes"
      #end
    end
  end
end