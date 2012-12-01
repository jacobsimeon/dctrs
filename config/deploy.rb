
ssh_options[:forward_agent] = true

set :application, "dctrs"
set :repository,  "git@github.com:jacobsimeon/dctrs.git"
set :user, 'ubuntu'
set :branch, "master"
set :deploy_via, :remote_cache
set :scm, :git
set :rvm_type, :system

role :web, "50.17.91.42"
role :app, "23.22.213.206"

require "rvm/capistrano"
require 'capistrano-unicorn'
require "bundler/capistrano"

