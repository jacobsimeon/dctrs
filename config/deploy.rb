
ssh_options[:forward_agent] = true

set :application, "dctrs"
set :repository,  "git@github.com:jacobsimeon/dctrs.git"
set :user, 'ubuntu'
set :branch, "master"
set :deploy_via, :remote_cache
set :scm, :git
set :rvm_type, :system

role :web, "dctrs.io"
role :app, "app1.dctrs.io"
role :app, "app2.dctrs.io"

require "rvm/capistrano"
require 'capistrano-unicorn'
require "bundler/capistrano"

