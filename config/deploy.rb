
ssh_options[:forward_agent] = true

set :application, "dctrs"
set :repository,  "git@github.com:jacobsimeon/dctrs.git"
set :user, 'ubuntu'
set :branch, "master"
set :deploy_via, :remote_cache
set :scm, :git
set :rvm_type, :system

role :web, "app1.dctrs.io", "app2.dctrs.io", "dctrs.io"
role :app, "app1.dctrs.io", "app2.dctrs.io"

require "rvm/capistrano"
require 'capistrano-unicorn'
require "bundler/capistrano"

#after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded
#after 'deploy:restart', 'unicorn:restart'  # app preloaded
