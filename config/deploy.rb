set :application, "dctors"
set :repository,  "git@github.com:jacobsimeon/dctrs.git"
set :user, 'ubuntu'
set :branch, "master"
set :deploy_via, :remote_cache
set :scm, :git

require "rvm/capistrano"
set :rvm_type, :system

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "54.234.0.235"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

ssh_options[:forward_agent] = true
require 'capistrano-unicorn'
require "bundler/capistrano"
