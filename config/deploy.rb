require 'bundler/capistrano'
load 'deploy/assets'

set :application, "thinginator"
set :domain, "tufnell.essex.ac.uk"

set :scm_username, 'paulgroves'
set :scm_password, 'Them4trix'

set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false
set :repository, "git@github.com:paulgroves/thinginator.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
role :db,  domain

set :deploy_to, applicationdir
set :deploy_via, :remote_cache

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

task :thinginator_prep do
  run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
end

before "deploy:assets:precompile", :thinginator_prep
