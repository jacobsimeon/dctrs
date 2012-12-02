
ssh_options[:forward_agent] = true

set :application, "dctrs"
set :repository,  "git@github.com:jacobsimeon/dctrs.git"
set :user, 'ubuntu'
set :branch, "master"
set :deploy_via, :remote_cache
set :scm, :git
set :rvm_type, :system

server "dctrs.io", :web
#server "app1.dctrs.io", :web, :app
server "app2.dctrs.io", :web, :app

require "rvm/capistrano"
require 'capistrano-unicorn'
require "bundler/capistrano"

after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'  # app preloaded
